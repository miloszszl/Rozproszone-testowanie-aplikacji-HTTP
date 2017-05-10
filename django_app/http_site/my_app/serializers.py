from rest_framework import serializers
from .models import User,Test,Page,Page_Test,Page_Connection,T_P_B,Button,Page_Host,Batch


class PageAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model=Page
        fields=('address',)


class Page_ConnectionSerializer(serializers.ModelSerializer):
    connected_page=PageAddressSerializer()

    class Meta:
        model=Page_Connection
        fields=('connected_page',)


class T_P_BSerializer(serializers.ModelSerializer):
    class Meta:
        model=T_P_B
        fields=('is_working',)

class ButtonSerializer(serializers.ModelSerializer):
    t_p_b=T_P_BSerializer(source='t_p_b_b',many=True)

    class Meta:
        model=Button
        fields=('locator', 't_p_b')


class PageSerializer(serializers.ModelSerializer):
    page_connections=Page_ConnectionSerializer(many=True)
    buttons=ButtonSerializer(many=True)

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
    page=PageSerializer()

    class Meta:
        model=Batch
        fields=('page','levels')


class TestSerializer(serializers.ModelSerializer):
    PagesTests=Page_TestSerializer(source='page_test_t',many=True)
    Batch=BatchSerializer(source='batch_t')

    class Meta:
        model=Test
        fields=('date','batch','page_test')


class UserSerializer(serializers.ModelSerializer):
    tests=TestSerializer(source='test_u',many=True)

    class Meta:
        model=User
        fields=('ipv4','transfer_speed','mac_address','tests')



class Page_HostSerializer(serializers.ModelSerializer):
    pages=PageSerializer(many=True)

    class Meta:
        model=Page_Host
        fields=('domain_name','ipv4')












