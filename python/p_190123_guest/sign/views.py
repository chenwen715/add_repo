from django.shortcuts import render
from django.http import HttpResponse,HttpResponseRedirect
from django.contrib import auth
from django.contrib.auth.decorators import login_required
import json
# Create your views here.
def index(request):
    #return HttpResponse("hello django")
    return render(request,"index.html")

def login_action(request):
    if request.method=="POST":
        un=request.POST.get('username','')
        pwd=request.POST.get('password','')
        user=auth.authenticate(username=un,password=pwd)#认证给出的用户名和密码
        if user:
            auth.login(request,user)#登录
            request.session['user']=un
            response=HttpResponseRedirect('/event_manage')
            #response.set_cookies('user',un,10)
            return response
        else:
            resp={}
            resp['username']=un
            resp['error']=u'用户名或密码错误'
            return HttpResponse(json.dumps(resp,ensure_ascii=False))
            #return render(request,"index.html",{'error':'用户名或密码错误'})

@login_required#只有登录页面能调用该函数
def event_manage(request):
    #username=request.COOKIES.get('user','')
    username=request.session.get('user','')
    return render(request,"event_manage.html",{'user':username})
