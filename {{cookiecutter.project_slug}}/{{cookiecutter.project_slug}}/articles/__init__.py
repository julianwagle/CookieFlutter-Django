from django.apps import AppConfig


class ArticlesAppConfig(AppConfig):
    name = '{{cookiecutter.project_slug}}.articles'
    label = 'articles'
    verbose_name = 'Articles'

    def ready(self):
        import {{cookiecutter.project_slug}}.articles.signals


default_app_config = '{{cookiecutter.project_slug}}.articles.ArticlesAppConfig'
