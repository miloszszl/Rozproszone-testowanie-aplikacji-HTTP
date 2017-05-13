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

    def create(self, validated_data):           #to do
        t_p_bs_data = validated_data.pop('t_p_b_b')
        button=Button.objects.get(locator=validated_data['locator'])
        if button is None:
            user = Button.objects.create(**validated_data)
        for t_p_b_data in t_p_bs_data:
            T_P_B.objects.create(button=button, **t_p_b_data)
        return button

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
    host=Page_HostSerializer(source='page_h',required=False,allow_null=True)

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

    def create(self, validated_data):
        pa=validated_data['page_address']
        addr=pa['address']
        page=Page.objects.filter(address=addr)
        if len(page)>0:
            batch=Batch.objects.create(levels=validated_data['levels'],page=page[0])
        else:
            batch = Batch.objects.create(levels=validated_data['levels'])
        return batch


class TestSerializer(serializers.ModelSerializer):
    pages_tests=Page_TestSerializer(source='page_test_t',many=True,required=False,allow_null=True)
    batch=BatchSerializer(source='batch_t',many=True,required=False,allow_null=True)

    class Meta:
        model=Test
        fields=('date','batch','pages_tests')

    def create(self, validated_data):
        data_for_batches = validated_data.pop('batch')#copy.deepcopy(validated_data)
        pages_test_data=validated_data.pop('page_test')

        test = Test.objects.create(**validated_data)

        for pt_data in pages_test_data:
            Page_Test.objects.create(test=test, **pt_data)
        for b_data in data_for_batches:
            Batch.objects.create(test=test, **b_data)

        return test


class UserSerializer(serializers.ModelSerializer):
    tests=TestSerializer(source='test_u',many=True,required=False,allow_null=True)

    class Meta:
        model=User
        fields=('ipv4', 'transfer_speed', 'mac_address', 'tests')

    def create(self, validated_data):
        tests = validated_data.pop('tests')
        user = User.objects.filter(mac_address=validated_data['mac_address'], ipv4=validated_data['ipv4'],
                                transfer_speed=validated_data['transfer_speed'])
        #user
        if len(user)<=0:
            user = User.objects.create(**validated_data)
        else:
            user=user[0]
        #tests
        for test in tests:
            t_cpy=copy.deepcopy(test)
            data_for_batches = test.pop('batch')  # copy.deepcopy(validated_data)
            pages_test_data = test.pop('pages_tests')

            t_obj = Test.objects.create(user=user,**test)

            for pt_data in pages_test_data:
                p_data=pt_data.pop('page')
                r_data=pt_data.pop('redirection')
                pt_obj=Page_Test.objects.create(test=t_obj, **pt_data)
                if p_data is not None:
                    host_data=p_data.pop('host')
                    page_connections=p_data.pop('page_connections')
                    buttons=p_data.pop('buttons')

                    Page.objects.create(**p_data)   #page_test=pt_obj,

                if r_data is not None:
                    pass


            for b_data in data_for_batches:
                p_a = b_data['page_address']
                addr = p_a['address']
                page = Page.objects.filter(address=addr)
                if len(page) > 0:
                    Batch.objects.create(test=t_obj, levels=b_data['levels'], page=page[0])
                else:
                    Batch.objects.create(test=t_obj, levels=b_data['levels'])
                #Batch.objects.create(test=t_obj, **b_data)

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















