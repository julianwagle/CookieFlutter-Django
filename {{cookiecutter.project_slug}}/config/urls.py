
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.urls import path
from django.views import defaults as default_views

from django.conf.urls import include
from django.views.generic import RedirectView
from {{cookiecutter.project_slug}}.users.api.views import VerifyEmailView
# from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path(settings.ADMIN_URL, admin.site.urls),
    path("api/", include("config.api_router")),

    path('api/', include('dj_rest_auth.urls')),
    # URLs that do not require a session or valid token
    # path('password/reset/', PasswordResetView.as_view(), name='rest_password_reset'),
    # path('password/reset/confirm/', PasswordResetConfirmView.as_view(), name='rest_password_reset_confirm'),
    # path('login/', LoginView.as_view(), name='rest_login'),
    # # URLs that require a user to be logged in with a valid session / token.
    # path('logout/', LogoutView.as_view(), name='rest_logout'),
    # path('user/', UserDetailsView.as_view(), name='rest_user_details'),
    # path('password/change/', PasswordChangeView.as_view(), name='rest_password_change'),


    path('api/registration/', include('dj_rest_auth.registration.urls')),
    # path('', RegisterView.as_view(), name='rest_register'),
    # path('verify-email/', VerifyEmailView.as_view(), name='rest_verify_email'),
    # path('resend-email/', ResendEmailVerificationView.as_view(), name="rest_resend_email"),
    # https://dj-rest-auth.readthedocs.io/en/latest/api_endpoints.html
    # https://github.com/iMerica/dj-rest-auth/blob/master/dj_rest_auth/registration/urls.py
    path('api/confirm-email/<key>/', VerifyEmailView.as_view(), name='email_verification_sent'),


    # path('account/', include('allauth.urls')),
    # path('accounts/profile/', RedirectView.as_view(url='/', permanent=True), name='profile-redirect'),

    # path("api/auth-token/", obtain_auth_token),
    path('api/', include('{{cookiecutter.project_slug}}.articles.urls', namespace='articles')),
    path('api/', include('{{cookiecutter.project_slug}}.profiles.urls', namespace='profiles')),

    # urls that don't perfectly adhere to realworld specs
    # path('users/', RegistrationAPIView.as_view()), => now api/registration
    # path('users/login/', LoginAPIView.as_view()), => now api/login

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    # This allows the error pages to be debugged during development, just visit
    # these url in browser to see how these error pages look like.
    urlpatterns += [
        path("400/", default_views.bad_request, kwargs={"exception": Exception("Bad Request!")},),
        path("403/", default_views.permission_denied, kwargs={"exception": Exception("Permission Denied")},),
        path("404/", default_views.page_not_found, kwargs={"exception": Exception("Page not Found")},),
        path("500/", default_views.server_error),
    ]
    # Static file serving when using Gunicorn + Uvicorn for local web socket development
    urlpatterns += staticfiles_urlpatterns()
    if "debug_toolbar" in settings.INSTALLED_APPS:
        import debug_toolbar
        urlpatterns = [path("__debug__/", include(debug_toolbar.urls))] + urlpatterns
