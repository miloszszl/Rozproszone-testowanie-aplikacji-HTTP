from django.conf.urls import url
from . import views
from .views import RespCodeChartData,TimeChartData
from django.views.generic.base import TemplateView
from django.contrib.auth import views as auth_views


urlpatterns = [
    url(r'^$', views.main_page, name='main_page'),
    url(r'^users/$', views.users_list, name='users_list'),
    url(r'^users/$', views.users_list, name='users_list'),
    url(r'^users/(?P<pk>[0-9]+)/$', views.user_detail, name='user_detail'),
    url(r'^tests/$', views.tests_list, name='tests_list'),
    url(r'^tests/(?P<pk>[0-9]+)/$', views.test_detail,name='test_detail'),
    url(r'^pages/$', views.pages_list, name='pages_list'),
    url(r'^pages/new/$', views.page_new, name='page_new'),
    url(r'^pages/(?P<pk>[0-9]+)/$', views.page_detail, name='page_detail'),
    url(r'^pages/(?P<pk>[0-9]+)/edit/$', views.page_edit, name='page_edit'),
    url(r'^pages/(?P<page_pk>[0-9]+)/buttons/(?P<button_pk>[0-9]+)/$', views.button_detail, name='button_detail'),
    url(r'^hosts/$', views.hosts_list, name='hosts_list'),
    url(r'^hosts/(?P<pk>[0-9]+)/$', views.host_detail, name='host_detail'),
    url(r'^pages/(?P<pk>[0-9]+)/api/resp_code_chart/data/$', RespCodeChartData.as_view(),name='resp_code_data'),
    url(r'^pages/(?P<pk>[0-9]+)/api/time_chart/data/$', TimeChartData.as_view(),name='time_data'),
    url(r'^pages/search/$', views.pages_search, name='pages_search'),
]