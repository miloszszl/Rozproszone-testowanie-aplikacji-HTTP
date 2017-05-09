from django.db import models
from django.utils import timezone

# Create your models here.

class User(models.Model):
    ipv4=models.CharField(max_length=15)
    transfer_speed=models.DecimalField(max_digits=7,decimal_places=2)       #mb/s
    mac_address=models.CharField(max_length=16)

    def __str__(self):
        return self.mac_address+' : '+self.ipv4

    class Meta:
        db_table='Users'

class Test(models.Model):
    user=models.ForeignKey('User', related_name='test_u',null=True)
    date=models.DateTimeField(default=timezone.now)

    class Meta:
        db_table='Tests'

class Batch(models.Model):
    page = models.ForeignKey('Page', related_name='batch_p')
    test = models.ForeignKey('Test', related_name='batch_t')
    levels = models.IntegerField()

    class Meta:
        db_table='Batch'

class Page_Test(models.Model):
    page=models.ForeignKey('Page',related_name='page_test_p')
    test=models.ForeignKey('Test',related_name='page_test_t')
    # with_pictures=models.BooleanField(default=False)
    is_working=models.BooleanField(default=True)
    redirection=models.ForeignKey('Page',related_name='page_test_r',null=True,blank=True)
    response_code=models.IntegerField()
    download_time=models.IntegerField(2000)

    class Meta:
        db_table = 'Pages_Tests'

# class Force_Tests(models.Model):
#     page=models.ForeignKey('Page')
#     levels=models.IntegerField()

    # def __str__(self):
    #     return self.date


# class Server(models.Model):
#     name=models.CharField(max_length=2000)
#     ipv4=models.CharField(max_length=15)
#
#     def __str__(self):
#         return self.name
#
#     class Meta:
#         db_table='Servers'

class Page_Host(models.Model):
    domain_name=models.CharField(max_length=2000)
    ipv4=models.CharField(max_length=15)

    class Meta:
        db_table="Page_hosts"

    def __str__(self):
        return "a"

class Page(models.Model):
    address=models.CharField(max_length=5000)
    weight=models.IntegerField(null=True,blank=True)   #kB
    weight_w_pictures=models.IntegerField(null=True,blank=True) #kB
    encoding=models.CharField(max_length=50,blank=True)
    cookies_present=models.BooleanField(default=None)
    avg_download_time=models.IntegerField(blank=True)  #ms
    force_test = models.BooleanField(default=False)
    host = models.ForeignKey('Page_Host',related_name='page_h',null=True,blank=True)

    # def __str__(self):
    #     return self.date

    class Meta:
        db_table='Pages'


class Page_Connection(models.Model):
    page_1=models.ForeignKey('Page', related_name='page_connection_1')
    page_2=models.ForeignKey('Page', related_name='page_connection_2')

    class Meta:
        db_table='Pages_Connections'

    def __str__(self):
        return "a"


class Button(models.Model):
    page = models.ForeignKey('Page', related_name='button_p')
    locator=models.CharField(max_length=5000)

    def __str__(self):
        return self.locator

    class Meta:
        db_table='Buttons'


class T_P_B(models.Model):
    button = models.ForeignKey('Button', related_name='t_p_b_b')
    is_working=models.BooleanField()
    page_test=models.ForeignKey('Page_Test',related_name='p_t_b_pt')

    class Meta:
        db_table='T_P_B'