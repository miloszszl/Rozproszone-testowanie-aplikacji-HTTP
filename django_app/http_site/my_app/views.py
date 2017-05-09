from django.shortcuts import render, get_object_or_404,redirect
from .models import User,Test,Page,Page_Test,Page_Connection,T_P_B,Button,Page_Host,Batch
from django.db.models import Q
from .forms import PageForm
from django.contrib.auth import authenticate, login,logout
from django.contrib.auth.decorators import login_required
from rest_framework.views import APIView
from rest_framework.response import Response
from django.db.models import Max,Min
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from django.utils.decorators import method_decorator
import re
from django.db.models import Q
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

# Create your views here.
def main_page(request):
    if request.method == "POST":
        if 'username' in request.POST and 'password' in request.POST:
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
        else:
            if request.user.is_authenticated():
                logout(request)
            return render(request, 'my_app/logged_out.html')

    return render(request, 'my_app/base.html')

@login_required
def users_list(request):
    users = User.objects.all().order_by('id')
    return render(request, 'my_app/users_list.html', {'users':users})

@login_required
def user_detail(request,pk):
    user = get_object_or_404(User, pk=pk)
    tests= user.test_u.all().order_by('date')                                                    #Test.objects.filter(users=user.pk)
    return render(request, 'my_app/user_detail.html', {'my_user': user,'my_user_tests':tests})

@login_required
def tests_list(request):
    tests=Test.objects.all().order_by('id')
    return render(request,'my_app/tests_list.html',{'tests':tests})

@login_required
def test_detail(request,pk):
    test = get_object_or_404(Test, pk=pk)
    batches = Batch.objects.filter(test=pk)
    pages_tests=Page_Test.objects.filter(test=pk)
    for pt in pages_tests:
        pt.t_p_b_pt=T_P_B.objects.filter(page_test=pt.pk)

    return render(request, 'my_app/test_detail.html', {'test': test,'batches':batches,'pages_tests':pages_tests})

@login_required
def pages_list(request):
    pages=Page.objects.all().order_by('address')
    page_number = request.GET.get('page_number', 1)
    paginator = Paginator(pages, 15)
    try:
        pages = paginator.page(page_number)
    except PageNotAnInteger:
        pages = paginator.page(1)
    except EmptyPage:
        pages = paginator.page(paginator.num_pages)

    return render(request,'my_app/pages_list.html',{'pages':pages})

@login_required
def page_detail(request,pk):
    page = get_object_or_404(Page, pk=pk)
    conn=Page_Connection.objects.filter(Q(page_1=pk) | Q(page_2=pk))
    links =[]
    for c in conn:
        if c.page_1 not in links:
            links.append(c.page_1)
        if c.page_2 not in links:
            links.append(c.page_2)

    buttons = Button.objects.filter(page=pk)
    for b in buttons:
        button_tests=T_P_B.objects.filter(button=b.pk)
        correct=0;
        for b_test in button_tests:
            if b_test.is_working==True:
                correct+=1

        button_working_percentage = None
        b_test_len=len(button_tests)
        if b_test_len>0:
            button_working_percentage=(correct*100.0)/len(button_tests)

        b.bb=button_working_percentage

    #is working % and redirection %
    pt=Page_Test.objects.filter(page=pk)
    tests_quantity=len(pt)
    pt_len=len(pt)
    if pt_len==0:
        is_working_percentage=None
        redirection_percentage=None
    else:
        is_working = 0
        redirections = 0
        for x in pt:
            if x.is_working == True:
                is_working += 1
            if not(x.redirection is None or x.redirection == ""):
                redirections += 1

        is_working_percentage=(is_working*100.0)/pt_len
        redirection_percentage=(redirections*100.0)/pt_len

    pages_tests = Page_Test.objects.filter(page=pk)
    for pt in pages_tests:
        pt.t_p_b_pt = T_P_B.objects.filter(page_test=pt.pk)

    return render(request, 'my_app/page_detail.html', {'page':page,'links':links,'buttons':buttons,
                                                       'is_working_percentage':is_working_percentage,
                                                       'redirection_percentage':redirection_percentage,
                                                       'tests_quantity':tests_quantity,
                                                       'pages_tests':pages_tests})


@login_required
def page_edit(request, pk):
    page = get_object_or_404(Page, pk=pk)
    if request.method == "POST":
        form = PageForm(request.POST, instance=page)
        if form.is_valid():
            page = form.save(commit=False)
            page.save()
            return redirect('page_detail', pk=page.pk)
    else:
        form = PageForm(instance=page)
    return render(request, 'my_app/page_edit.html', {'form': form,'page':page})

@login_required
def page_new(request):
    if request.method == "POST":
        form = PageForm(request.POST)
        if form.is_valid():
            page = form.save(commit=False)
            db_pages = Page.objects.filter(address=page.address)
            if not db_pages:
                page.avg_download_time=0
                page.save()
                return redirect('page_detail', pk=page.pk)
            else:
                error='This address already exists'
                return render(request, 'my_app/page_new.html', {'form': form,'error':error})
        else:
            error = '1111'
            return render(request, 'my_app/page_new.html', {'form': form,'error':error})
    else:
        form = PageForm()
        return render(request, 'my_app/page_new.html', {'form': form})

@login_required
def button_detail(request,button_pk,page_pk):
    button = get_object_or_404(Button, pk=button_pk)
    button_tests = T_P_B.objects.filter(button=button.pk)

    tests_quantity=len(button_tests)
    correct = 0;
    for b_test in button_tests:
        if b_test.is_working == True:
            correct += 1

    button_working_percentage = None
    b_test_len = len(button_tests)
    if b_test_len > 0:
        button_working_percentage = (correct * 100.0) / len(button_tests)

    button.bb = button_working_percentage

    return render(request, 'my_app/button_detail.html', {'button': button,'tests_quantity':tests_quantity})

@login_required
def hosts_list(request):
    hosts = Page_Host.objects.all()
    return render(request, 'my_app/hosts_list.html', {'hosts':hosts})

@login_required
def host_detail(request,pk):
    host = get_object_or_404(Page_Host, pk=pk)
    pages=Page.objects.filter(host=pk)
    return render(request, 'my_app/host_detail.html', {'host': host,'pages':pages})



class RespCodeChartData(APIView):
    authentication_classes = (SessionAuthentication, BasicAuthentication)
    permission_classes = (IsAuthenticated,)

    def get(self, request,pk, format=None):
        if  Page_Test.objects.filter(page=pk).count()>0:
            resp=[{'1XX': 0},{'2XX': 0},{'3XX': 0},{'4XX': 0},{'5XX': 0}]
            for i in range(1, 6):
                arg = str(i)+'XX'
                resp[i-1][arg] = Page_Test.objects.filter(page=pk, response_code__startswith=str(i)).count()
        else:
            resp=None
        return Response(resp)


class TimeChartData(APIView):
    authentication_classes = (SessionAuthentication, BasicAuthentication)
    permission_classes = (IsAuthenticated,)

    def get(self, request,pk, format=None):
        intervals=[]
        occurrences=[]
        pt_max=Page_Test.objects.filter(page=pk).aggregate(Max('download_time'))
        pt_min=Page_Test.objects.filter(page=pk).aggregate(Min('download_time'))
        quantity=Page_Test.objects.filter(page=pk).count();
        intervals_quantity=0

        if quantity==1:
            intervals_quantity=1
        elif quantity == 2 :
            intervals_quantity=2
        elif quantity >= 3 and quantity < 10:
            intervals_quantity=3
        elif quantity>=10 and quantity<50:
            intervals_quantity = 6
        else:
            intervals_quantity=10

        if(pt_max !=None and pt_min!=None and len(pt_max)>0 and len(pt_min)>0 and
                   intervals_quantity>0 and pt_max['download_time__max']!=None and pt_min['download_time__min']!=None):
            diff = pt_max['download_time__max'] - pt_min['download_time__min']
            inc = diff / intervals_quantity

            for i in range(0, intervals_quantity):
                intervals.append(pt_min['download_time__min'] + inc * i)

            intervals.append(pt_max['download_time__max'])

            if len(intervals) == 2:
                occurrences.append(Page_Test.objects.filter(page=pk, download_time=pt_max['download_time__max']).count())
            else:
                for i in range(0, intervals_quantity):
                    occurrences.append( Page_Test.objects.filter(page=pk, download_time__lt=intervals[i + 1],
                                                           download_time__gte=intervals[i]).count())

            occurrences.append(Page_Test.objects.filter(page=pk, download_time=pt_max['download_time__max']).count())
        else:
            return Response(None)
        return Response({'intervals':intervals,'occurrences':occurrences})


def normalize_query(query_string,
                    findterms=re.compile(r'"([^"]+)"|(\S+)').findall,
                    normspace=re.compile(r'\s{2,}').sub):
    ''' Splits the query string in invidual keywords, getting rid of unecessary spaces
        and grouping quoted words together.
        Example:

        >>> normalize_query('  some random  words "with   quotes  " and   spaces')
        ['some', 'random', 'words', 'with quotes', 'and', 'spaces']

    '''
    return [normspace(' ', (t[0] or t[1]).strip()) for t in findterms(query_string)]


def get_query(query_string, search_fields):
    ''' Returns a query, that is a combination of Q objects. That combination
        aims to search keywords within a model by testing the given search fields.

    '''
    query = None  # Query to search for every search term
    terms = normalize_query(query_string)
    for term in terms:
        or_query = None  # Query to search for a given term in each field
        for field_name in search_fields:
            q = Q(**{"%s__icontains" % field_name: term})
            if or_query is None:
                or_query = q
            else:
                or_query = or_query | q
        if query is None:
            query = or_query
        else:
            query = query & or_query
    return query


@login_required
def pages_search(request):
    query_string = ''
    found_entries = None
    print("sada")
    if ('q' in request.GET) and request.GET['q'].strip():
        query_string = request.GET['q']

        entry_query = get_query(query_string, ['address'])

        found_entries = Page.objects.filter(entry_query).order_by('address')

    return render(request,'my_app/pages_list.html',{'query_string': query_string, 'pages': found_entries})