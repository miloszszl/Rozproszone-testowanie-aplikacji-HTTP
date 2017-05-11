from rest_framework import serializers
from .models import User,Test,Page,Page_Test,Page_Connection,T_P_B,Button,Page_Host,Batch
from django.db.models import Max,Min

class Page_HostSerializer(serializers.ModelSerializer):

    class Meta:
        model=Page_Host
        fields=('domain_name','ipv4')


class PageAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model=Page
        fields=('address',)


class Page_ConnectionSerializer(serializers.ModelSerializer):
    page_2 = PageAddressSerializer()

    class Meta:
        model=Page_Connection
        fields=('page_2',)


class T_P_BSerializer(serializers.ModelSerializer):
    class Meta:
        model=T_P_B
        fields=('is_working',)

class ButtonSerializer(serializers.ModelSerializer):
    #t_p_b=T_P_BSerializer(source='t_p_b_b',many=True)          for additional fields
    working_percentage=serializers.SerializerMethodField('working_percentage_calc')

    def working_percentage_calc(self,obj):
        button_tests = T_P_B.objects.filter(button=obj.pk)
        button_working_percentage = None
        tests_quantity = len(button_tests)
        if tests_quantity > 0:
            correct = 0;
            for b_test in button_tests:
                if b_test.is_working == True:
                    correct += 1

            button_working_percentage = (correct * 100.0) / tests_quantity

        return button_working_percentage

    class Meta:
        model=Button
        fields=('locator', 'working_percentage') #'t_p_b' for additional fields


class PageSerializer(serializers.ModelSerializer):
    page_connections=Page_ConnectionSerializer(source='page_connection_1',many=True)
    buttons=ButtonSerializer(source='button_p',many=True)
    host=Page_HostSerializer()

    class Meta:
        model=Page
        fields=('address','weight','encoding','cookies_present','avg_download_time',
                'force_test','weight_w_pictures','host','page_connections','buttons')

class Page_TestSerializer(serializers.ModelSerializer):
    page=PageSerializer()
    redirection=PageSerializer()

    class Meta:
        model=Page_Test
        fields=('is_working','response_code','download_time','page',
                'redirection')


class BatchSerializer(serializers.ModelSerializer):
    page=PageAddressSerializer()

    class Meta:
        model=Batch
        fields=('page','levels')


class TestSerializer(serializers.ModelSerializer):
    pages_tests=Page_TestSerializer(source='page_test_t',many=True)
    batch=BatchSerializer(source='batch_t')

    class Meta:
        model=Test
        fields=('date','batch','pages_tests')


class UserSerializer(serializers.ModelSerializer):
    tests=TestSerializer(source='test_u',many=True)

    class Meta:
        model=User
        fields=('ipv4','transfer_speed','mac_address','tests')


class Page_For_ClientSerializer(serializers.ModelSerializer):
    min_download_time = serializers.SerializerMethodField('min_download_time_calc')
    max_download_time = serializers.SerializerMethodField('max_download_time_calc')
    host = Page_HostSerializer()

    def min_download_time_calc(self, obj):
        min_time=Page_Test.objects.filter(page=obj.pk).aggregate(Min('download_time'))
        return min_time['download_time__min']

    def max_download_time_calc(self, obj):
        max_time=Page_Test.objects.filter(page=obj.pk).aggregate(Max('download_time'))
        return max_time['download_time__max']

    class Meta:
        model=Page
        fields=('address','weight','encoding','cookies_present','force_test','weight_w_pictures',
                'host','avg_download_time','min_download_time','max_download_time','global_working_percentage',
                'last_month_working_percentage',)















