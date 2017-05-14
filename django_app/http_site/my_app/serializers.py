from rest_framework import serializers
from .models import User,Test,Page,Page_Test,Page_Connection,T_P_B,Button,Page_Host,Batch
from django.db.models import Max,Min
import copy

class Page_HostSerializer(serializers.ModelSerializer):

    class Meta:
        model=Page_Host
        fields=('domain_name','ipv4')


class PageAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model=Page
        fields=('address',)


class Page_ConnectionSerializer(serializers.ModelSerializer):
    page_2 = PageAddressSerializer(required=False,allow_null=True)

    class Meta:
        model=Page_Connection
        fields=('page_2',)


class T_P_BSerializer(serializers.ModelSerializer):
    class Meta:
        model=T_P_B
        fields=('is_working',)


class ButtonSerializer(serializers.ModelSerializer):
    t_p_b=T_P_BSerializer(source='t_p_b_b',many=True,required=False,allow_null=True)
    # working_percentage=serializers.SerializerMethodField('working_percentage_calc')

    # def working_percentage_calc(self,obj):
    #     button_tests = T_P_B.objects.filter(button=obj.pk)
    #     button_working_percentage = None
    #     tests_quantity = len(button_tests)
    #     if tests_quantity > 0:
    #         correct = 0;
    #         for b_test in button_tests:
    #             if b_test.is_working == True:
    #                 correct += 1
    #
    #         button_working_percentage = (correct * 100.0) / tests_quantity
    #
    #     return button_working_percentage

    # def create(self, validated_data):           #to do
    #     t_p_bs_data = validated_data.pop('t_p_b_b')
    #     button=Button.objects.get(locator=validated_data['locator'])
    #     if button is None:
    #         user = Button.objects.create(**validated_data)
    #     for t_p_b_data in t_p_bs_data:
    #         T_P_B.objects.create(button=button, **t_p_b_data)
    #     return button

    class Meta:
        model=Button
        fields=('locator', 'global_working_percentage','last_month_working_percentage','t_p_b') #'t_p_b' for additional fields

# class ButtonOriginalSerializer(serializers.ModelSerializer):
#     t_p_b=T_P_BSerializer(source='t_p_b_b',many=True)
#
#     class Meta:
#         model = Button
#         fields = ('locator', 't_p_b')

class PageSerializer(serializers.ModelSerializer):
    page_connections=Page_ConnectionSerializer(source='page_connection_1',many=True,required=False,allow_null=True)
    buttons=ButtonSerializer(source='button_p',many=True,required=False,allow_null=True)
    host=Page_HostSerializer(required=False,allow_null=True)

    class Meta:
        model=Page
        fields=('address','weight','encoding','cookies_present','avg_download_time','global_working_percentage',
                'last_month_working_percentage', 'force_test','weight_w_pictures','host','page_connections','buttons')


class Page_TestSerializer(serializers.ModelSerializer):
    page=PageSerializer(required=False,allow_null=True)
    redirection=PageSerializer(required=False,allow_null=True)

    class Meta:
        model=Page_Test
        fields=('is_working','response_code','download_time','page',
                'redirection')

    # def create(self, validated_data):
    #     page = validated_data.pop('page')
    #     redirection = validated_data.pop('redirection')
    #     # copy.deepcopy(validated_data)
    #     page_test = Page_Test.objects.create(**validated_data)

        # for pt_data in pages_test_data:
        #     Page_Test.objects.create(test=test, **pt_data)
        # for b_data in data_for_batches:
        #     Batch.objects.create(test=test, **b_data)

        #return page_test


class BatchSerializer(serializers.ModelSerializer):
    page_address=PageAddressSerializer(source='page')

    class Meta:
        model=Batch
        fields=('levels','page_address',)

    # def create(self, validated_data):
    #     pa=validated_data['page_address']
    #     addr=pa['address']
    #     page=Page.objects.filter(address=addr)
    #     if len(page)>0:
    #         batch=Batch.objects.create(levels=validated_data['levels'],page=page[0])
    #     else:
    #         batch = Batch.objects.create(levels=validated_data['levels'])
    #     return batch


class TestSerializer(serializers.ModelSerializer):
    pages_tests=Page_TestSerializer(source='page_test_t',many=True,required=False,allow_null=True)
    batch=BatchSerializer(source='batch_t',many=True,required=False,allow_null=True)

    class Meta:
        model=Test
        fields=('date','batch','pages_tests')

    # def create(self, validated_data):
    #     data_for_batches = validated_data.pop('batch')#copy.deepcopy(validated_data)
    #     pages_test_data=validated_data.pop('page_test')
    #
    #     test = Test.objects.create(**validated_data)
    #
    #     for pt_data in pages_test_data:
    #         Page_Test.objects.create(test=test, **pt_data)
    #     for b_data in data_for_batches:
    #         Batch.objects.create(test=test, **b_data)
    #
    #     return test


class UserSerializer(serializers.ModelSerializer):
    tests=TestSerializer(source='test_u',many=True,required=False,allow_null=True)

    class Meta:
        model=User
        fields=('ipv4', 'transfer_speed', 'mac_address', 'tests')

    def create(self, validated_data):
        tests_list = validated_data.pop('tests', None)
        user = User.objects.filter(mac_address=validated_data['mac_address'], ipv4=validated_data['ipv4'],
                                transfer_speed=validated_data['transfer_speed'])
        #user
        if len(user)<=0:
            user = User.objects.create(**validated_data)
        else:
            user=user[0]
        #tests
        if tests_list is not None:
            for test in tests_list:
                if test is not None:
                    batches_list = test.pop('batch', None)
                    pages_tests_list = test.pop('pages_tests', None)
                    t_obj = Test.objects.create(user=user, **test)

                    if pages_tests_list is not None:
                        for pt_data in pages_tests_list:
                            if pt_data is not None:
                                page_data=pt_data.pop('page', None)
                                redirection_data=pt_data.pop('redirection', None)

                                r_obj=None
                                p_obj=None
                                pt_obj=None
                                if page_data is not None:
                                    host_data=page_data.pop('host', None)
                                    ph_obj=Page_Host.objects.filter(domain_name=host_data['domain_name'], ipv4=host_data['ipv4'])
                                    if len(ph_obj)<=0:
                                        ph_obj=Page_Host.objects.create(**host_data)
                                    else:
                                        ph_obj=ph_obj[0]

                                    page_connections_list=page_data.pop('page_connections', None)
                                    buttons_list=page_data.pop('buttons', None)
                                    p_obj=Page.objects.filter(address=page_data['address'])
                                    if len(p_obj)<=0:
                                        p_obj=Page.objects.create(host=ph_obj,**page_data)
                                    else:
                                        p_obj=p_obj[0]

                                    pt_obj=Page_Test.objects.create(test=t_obj, page=p_obj, redirection=None, **pt_data)

                                    if page_connections_list is not None:
                                        for pc in page_connections_list:
                                            if pc is not None:
                                                page_2=pc['page_2']
                                                page_for_pc=Page.objects.filter(address=page_2['address'])
                                                if page_for_pc is not None and len(page_for_pc)>0:
                                                    page_2_for_pc=page_for_pc[0]
                                                    Page_Connection.objects.create(page_1=p_obj,page_2=page_2_for_pc)
                                                else:
                                                    page_2_for_pc = Page.objects.create(address=page_2['address'])
                                                    Page_Connection.objects.create(page_1=p_obj, page_2=page_2_for_pc)

                                    #buttons
                                    if buttons_list is not None:
                                        for button in buttons_list:
                                            if button is not None:
                                                t_p_b_list=button.pop('t_p_b', None)
                                                b=Button.objects.filter(locator=button['locator'],page=p_obj)
                                                if b is None or len(b) <= 0:
                                                    b = Button.objects.create(page=p_obj, **button)
                                                else:
                                                    b=b[0]

                                                for t_p_b in t_p_b_list:
                                                    if t_p_b is not None:
                                                        T_P_B.objects.create(button=b, page_test=pt_obj, is_working=t_p_b['is_working'])
#looks good up to that moment
                                if redirection_data is not None:
                                    host_data = page_data.pop('host', None)
                                    ph_obj = Page_Host.objects.filter(domain_name=host_data['domain_name'],
                                                                      ipv4=host_data['ipv4'])
                                    if len(ph_obj) <= 0:
                                        ph_obj = Page_Host.objects.create(**host_data)
                                    else:
                                        ph_obj = ph_obj[0]

                                    page_connections_list = page_data.pop('page_connections', None)
                                    buttons_list = page_data.pop('buttons', None)
                                    p_obj = Page.objects.create(host=ph_obj, **page_data)
                                    pt_obj = Page_Test.objects.create(test=t_obj, page=p_obj, redirection=None,
                                                                      **pt_data)

                                    if page_connections_list is not None:
                                        for pc in page_connections_list:
                                            if pc is not None:
                                                page_2 = pc['page_2']
                                                page_for_pc = Page.objects.filter(address=page_2['address'])
                                                if page_for_pc is not None and len(page_for_pc) > 0:
                                                    page_2_for_pc = page_for_pc[0]
                                                    Page_Connection.objects.create(page_1=p_obj, page_2=page_2_for_pc)
                                                else:
                                                    page_2_for_pc = Page.objects.create(address=page_2['address'])
                                                    Page_Connection.objects.create(page_1=p_obj, page_2=page_2_for_pc)

                                    # buttons
                                    if buttons_list is not None:
                                        for button in buttons_list:
                                            if button is not None:
                                                t_p_b_list = button.pop('t_p_b', None)
                                                b = Button.objects.filter(locator=button['locator'], page=p_obj)
                                                if b is None or len(b) <= 0:
                                                    b = Button.objects.create(page=p_obj, **button)
                                                else:
                                                    b = b[0]

                                                for t_p_b in t_p_b_list:
                                                    if t_p_b is not None:
                                                        T_P_B.objects.create(button=b, page_test=pt_obj,
                                                                             is_working=t_p_b['is_working'])



                    for b_data in batches_list:
                        p_a = b_data['page_address']
                        addr = p_a['address']
                        page = Page.objects.filter(address=addr)
                        if len(page) > 0:
                            Batch.objects.create(test=t_obj, levels=b_data['levels'], page=page[0])
                        else:
                            Batch.objects.create(test=t_obj, levels=b_data['levels'])


        return user


class Page_For_ClientSerializer(serializers.ModelSerializer):
    min_download_time = serializers.SerializerMethodField('min_download_time_calc')
    max_download_time = serializers.SerializerMethodField('max_download_time_calc')

    def min_download_time_calc(self, obj):
        min_time=Page_Test.objects.filter(page=obj.pk).aggregate(Min('download_time'))
        return min_time['download_time__min']

    def max_download_time_calc(self, obj):
        max_time=Page_Test.objects.filter(page=obj.pk).aggregate(Max('download_time'))
        return max_time['download_time__max']

    class Meta:
        model=Page
        fields=('address','avg_download_time','min_download_time','max_download_time','global_working_percentage',
                'last_month_working_percentage',)















