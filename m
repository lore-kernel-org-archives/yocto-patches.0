Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBECDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 18:08:12 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13931.1782324486187370454
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 11:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=JlmyNYIF;
 spf=pass (domain: qbee.io, ip: 209.85.208.42, mailfrom: piotr@qbee.io)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso2590874a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 11:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782324484; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+8XRYL8vqa7Xtn5+cu9cZ66W/nsdZ4890LJ4ppXaAgiBPsdc7tTW1JfoahYKGP1hI
         vaiQAcIxdsfj/CELEiyxneXVKKeUEkgNd0z0d0xUUmVsAoJkemYaOrABEXBIQ+4ETjZh
         eY3LpGeQqtumK6afAn5LOhzWmnD4FvZUXvG6vAkKSDpFI76Gi0AN110Im1qSi1u+Gv9K
         XM+1+1HRspPu258F1cAZuw2gQ38A2+joww+pqyt4n3Va+Huc+2SRFJYxUF5qFWk2xAaD
         +HM4bdTosd0qA8oamtmkbSb/AcrkYiEUx1eacET+uhLFrBOwcU8ljJM5Di0SOBqYtAOz
         kErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jadVyT3I+6zGImgcvCoWEB9Qr64jyMoPSbGLrNIj9/U=;
        fh=mb3LbRBBTguxXSQtFTPqWBlhFDjF4kCC3kciY6zXgJA=;
        b=lt0b97PxY5qaj38HpxYLxmvhz5IzRmd9luRuDfFuTg8IUM8c4o3DxsU2L/wBvNRGE6
         ZNFyf0MsoJZEOGvDUYUxoqg8CreVajk9NNJt8uDH1o/tv9RR2mGzpB0lTYJGoP4Aa9AU
         nki7um3RxeTCKGk3YF7jOYBrxOUK5SZ/GOMPiaV70wRSIDEx+oeSciJYMm5jQUNXFKkT
         lM9vdAlAo7eEWLs7k42TnTkUo5yMRiPo8zxGma86bNGL67ePXDl7+zAkUKSgFUd1R4Ud
         HH8mQVAFS1GuBXTAAtXhfrTdfX7rAhHKfHF5l1cl0oAV7DIPOgU+M9XSEMLcasEPlV0f
         I2/w==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1782324484; x=1782929284; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jadVyT3I+6zGImgcvCoWEB9Qr64jyMoPSbGLrNIj9/U=;
        b=JlmyNYIFKNnzSqFWhKKkg3cs9l3UYB2XvPquaak7o527+3BuwwQ8Jm3Gz8VJ+VpH/8
         qC7+Nvy4VXNaxOUUqVvuUnv7hvgjzg1eQ3ZplfQWVGaHlqcjTXzCLKGnw2vbNeocKzqx
         MiOM6KoNvWTwU7n4nG/EFkDNqfj4IyIi+YWEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782324484; x=1782929284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jadVyT3I+6zGImgcvCoWEB9Qr64jyMoPSbGLrNIj9/U=;
        b=eb9PwqwREvc3OO1yx92dihtfoQHF55g5Nyk28k9koWM+07JlRvnwFs7PrcDp2kDc3B
         KC5Ia8b7Fhe4aIlKNeUpQ7q0kgKr3ojib7k4xAkKqTkeTiyLZX7G4L+9NDlT3EbjdMFk
         2N8TMQhYFpm9Od7Oz1nqbyONaHcdvtNidW14tJ7AKIek98XecAcJPNjSzi6+jCNtGOG8
         aqEmSllbWyOVqpUwLslgyM91/AtzCQ30nTSodoghRooqxRpGfVvPs1jqo2V8YuLo+ekB
         iOdgAdqqsM/h52yobNzUZPznexeKULRv1ihNjhKYMDsuPOdsUJeeycDXPoNfYp0AK74q
         1EgA==
X-Gm-Message-State: AOJu0Yw5E/w1WHiSdRFx45QgWxvcnjgADUYhbSWDa2996EYpZBp90wJ3
	eD6ATcjzaOo6lJShE4XsC9Hr9l2859LFZp2QOQziiWNHwdOKWEcf4yYyJwGEX7ukv71cNVXzRMm
	1j8/3jw7phITm7D1QQm/iiRMC+RTa9WvcVtBsBAoDqA==
X-Gm-Gg: AfdE7clcfh/U4Z9Yp6LpB45tMAPmVj9NJn3I/fis7tj1OZkoYLQDMif2Vh/niXTGZZ7
	q8hoJ0VRZ3rvQwhUXQlDCG5/mDp39JQcfYlCx5ODgA03BbeqJ9VLhVu2wl9UE1ACnKH8Jt4joza
	b9vxXc/dmPCTR7dfBFHMr2VjQvE9A9UGowIvVcHsp4rRIzT67Y6NJ63I5pRgn+yu036pIzcetBZ
	HVnkyugDiMqmuE3f/TK0SNKEESfuku6e1Xp7jvAE+/WvGZULYCcApJes4ng2MOutAdUuIQ=
X-Received: by 2002:a05:6402:3513:b0:695:572a:7abb with SMTP id
 4fb4d7f45d1cf-697f3aa9d78mr2486855a12.22.1782324484036; Wed, 24 Jun 2026
 11:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260619215252.2803094-1-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260619215252.2803094-1-sandeep.gundlupet-raju@amd.com>
From: Piotr Bulinski <piotr@qbee.io>
Date: Wed, 24 Jun 2026 20:07:53 +0200
X-Gm-Features: AVVi8CcTcRcc3rDqJgCN6qwVnGDn28u6euAs1RRAXPL7RZsQOdANBk-pjLj8xpA
Message-ID: <CAGjhzsKyprtbc53Ra2MiP31bygMhmmzg5NHhgo3b_snZNjj3YA@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH 1/1] layerindex: Use
 settings.DEFAULT_BRANCH instead of hardcoded branch name
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Cc: yocto-patches@lists.yoctoproject.org, tim.orling@konsulko.com, 
	mark.hatle@kernel.crashing.org
Content-Type: multipart/alternative; boundary="000000000000beebd6065503c13a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 18:08:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4299

--000000000000beebd6065503c13a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sandeep,

Thank you for the patch.

In the layerindex/update_layer.py you are updating the default value
of `--branch`
to an empty string,
which is inconsistent with the rest of the changes in this patch.

In the same file, system settings are already imported at line 298, so
perhaps that import should be moved above the parser logic
to allow you to use `settings.DEFAULT_BRANCH` as a default value for the
`--branch` option instead of an empty string.

Best regards,
Piotr Buli=C5=84ski

On Fri, Jun 19, 2026 at 11:52=E2=80=AFPM Sandeep Gundlupet Raju <
sandeep.gundlupet-raju@amd.com> wrote:

> Replace all hardcoded branch name references with settings.DEFAULT_BRANCH
> so the default branch can be changed from a single location in settings.p=
y
> without modifying individual source files. DEFAULT_BRANCH defaults to
> 'master'.
>
> - settings.py: add DEFAULT_BRANCH =3D 'master'
> - docker/settings.py: add DEFAULT_BRANCH =3D 'master'
> - layerindex/urls.py: use _DEFAULT_BRANCH from settings
> - layerindex/views.py: use settings.DEFAULT_BRANCH (10 occurrences)
> - layerindex/models.py: add import settings; use settings.DEFAULT_BRANCH
> - layerindex/update.py: use settings.DEFAULT_BRANCH
> - layerindex/update_layer.py: resolve branch from settings.DEFAULT_BRANCH
> - layerindex/bulkchange.py: use settings.DEFAULT_BRANCH
> - layerindex/tools/import_layer.py: use settings.DEFAULT_BRANCH
> - layerindex/tools/import_wiki_layers.py: add import settings; use
> DEFAULT_BRANCH
> - layerindex/tools/import_classic_wiki.py: add import settings; use
> DEFAULT_BRANCH
> - layerindex/tools/update_classic_status.py: add import settings; use
> DEFAULT_BRANCH
> - rrs/tools/historytool.py: use settings.DEFAULT_BRANCH
>
> AI-Generated: GitHub Copilot (Claude Sonnet 4.6)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  docker/settings.py                        |  2 ++
>  layerindex/bulkchange.py                  |  2 +-
>  layerindex/models.py                      |  5 +++--
>  layerindex/tools/import_classic_wiki.py   |  3 ++-
>  layerindex/tools/import_layer.py          |  4 ++--
>  layerindex/tools/import_wiki_layers.py    |  3 ++-
>  layerindex/tools/update_classic_status.py |  7 ++++---
>  layerindex/update.py                      |  2 +-
>  layerindex/update_layer.py                |  4 +++-
>  layerindex/urls.py                        | 16 +++++++++-------
>  layerindex/views.py                       | 20 ++++++++++----------
>  rrs/tools/historytool.py                  |  4 ++--
>  settings.py                               |  3 +++
>  13 files changed, 44 insertions(+), 31 deletions(-)
>
> diff --git a/docker/settings.py b/docker/settings.py
> index e3ae0fd..85b7efd 100644
> --- a/docker/settings.py
> +++ b/docker/settings.py
> @@ -315,3 +315,5 @@ SECURE_PROXY_SSL_HEADER =3D ('HTTP_X_FORWARDED_PROTO'=
,
> 'https')
>  SECURE_BROWSER_XSS_FILTER =3D True
>  SECURE_CONTENT_TYPE_NOSNIFF =3D True
>
> +# Default branch name used across the layer index
> +DEFAULT_BRANCH =3D 'master'
> diff --git a/layerindex/bulkchange.py b/layerindex/bulkchange.py
> index 0ec4058..11cd7a6 100644
> --- a/layerindex/bulkchange.py
> +++ b/layerindex/bulkchange.py
> @@ -98,7 +98,7 @@ def main():
>      utils.setup_django()
>      import settings
>
> -    branch =3D utils.get_branch('master')
> +    branch =3D utils.get_branch(settings.DEFAULT_BRANCH)
>      fetchdir =3D settings.LAYER_FETCH_DIR
>
>      import layerindex.models import LayerItem
> diff --git a/layerindex/models.py b/layerindex/models.py
> index 864264b..7a09962 100644
> --- a/layerindex/models.py
> +++ b/layerindex/models.py
> @@ -18,6 +18,7 @@ import os.path
>  import re
>  import posixpath
>  import codecs
> +import settings
>
>  from . import utils
>
> @@ -190,7 +191,7 @@ class LayerItem(models.Model):
>          return fetch_dir
>
>      def get_absolute_url(self):
> -        return reverse('layer_item', args=3D('master',self.name));
> +        return reverse('layer_item', args=3D(settings.DEFAULT_BRANCH,
> self.name));
>
>      def __str__(self):
>          return self.name
> @@ -672,7 +673,7 @@ class ClassicRecipe(Recipe):
>          ('E', 'Equivalent functionality'),
>          ('D', 'Direct match'),
>      ]
> -    cover_layerbranch =3D models.ForeignKey(LayerBranch,
> verbose_name=3D'Covering layer', blank=3DTrue, null=3DTrue, limit_choices=
_to =3D
> {'branch__name': 'master'}, on_delete=3Dmodels.SET_NULL)
> +    cover_layerbranch =3D models.ForeignKey(LayerBranch,
> verbose_name=3D'Covering layer', blank=3DTrue, null=3DTrue, limit_choices=
_to =3D
> {'branch__name': settings.DEFAULT_BRANCH}, on_delete=3Dmodels.SET_NULL)
>      cover_pn =3D models.CharField('Covering recipe', max_length=3D100,
> blank=3DTrue)
>      cover_status =3D models.CharField(max_length=3D1,
> choices=3DCOVER_STATUS_CHOICES, default=3D'U')
>      cover_verified =3D models.BooleanField(default=3DFalse)
> diff --git a/layerindex/tools/import_classic_wiki.py
> b/layerindex/tools/import_classic_wiki.py
> index bd7ab9a..e8c4c8c 100755
> --- a/layerindex/tools/import_classic_wiki.py
> +++ b/layerindex/tools/import_classic_wiki.py
> @@ -84,6 +84,7 @@ def main():
>      options, args =3D parser.parse_args(sys.argv)
>
>      utils.setup_django()
> +    import settings
>      from layerindex.models import LayerItem, LayerBranch, Recipe,
> ClassicRecipe
>      from django.db import transaction
>
> @@ -178,7 +179,7 @@ def main():
>                              res =3D
> list(LayerItem.objects.filter(name=3Dnewlayer)[:1])
>                              if res:
>                                  newlayeritem =3D res[0]
> -                                recipe.cover_layerbranch =3D
> newlayeritem.get_layerbranch('master')
> +                                recipe.cover_layerbranch =3D
> newlayeritem.get_layerbranch(settings.DEFAULT_BRANCH)
>                              else:
>                                  logger.info('Replacement layer "%s" for
> %s could not be found' % (newlayer, pn))
>                          recipe.cover_pn =3D newpn
> diff --git a/layerindex/tools/import_layer.py
> b/layerindex/tools/import_layer.py
> index 79c679e..cdbd40d 100755
> --- a/layerindex/tools/import_layer.py
> +++ b/layerindex/tools/import_layer.py
> @@ -284,7 +284,7 @@ def main():
>      if not os.path.exists(fetchdir):
>          os.makedirs(fetchdir)
>
> -    master_branch =3D utils.get_branch('master')
> +    master_branch =3D utils.get_branch(settings.DEFAULT_BRANCH)
>      core_layer =3D None
>      try:
>          with transaction.atomic():
> @@ -311,7 +311,7 @@ def main():
>                  logger.error("Fetch failed: %s" % str(e))
>                  sys.exit(1)
>
> -            actual_branch =3D 'master'
> +            actual_branch =3D settings.DEFAULT_BRANCH
>              if (options.actual_branch):
>                  actual_branch =3D options.actual_branch
>              try:
> diff --git a/layerindex/tools/import_wiki_layers.py
> b/layerindex/tools/import_wiki_layers.py
> index 061f6df..f287bf6 100755
> --- a/layerindex/tools/import_wiki_layers.py
> +++ b/layerindex/tools/import_wiki_layers.py
> @@ -35,6 +35,7 @@ def main():
>      options, args =3D parser.parse_args(sys.argv)
>
>      utils.setup_django()
> +    import settings
>      from layerindex.models import LayerItem, LayerBranch, LayerDependenc=
y
>      from django.db import transaction
>
> @@ -49,7 +50,7 @@ def main():
>          nowiki_re =3D re.compile(r'</?nowiki>')
>          link_re =3D re.compile(r'\[(http.*) +link\]')
>          readme_re =3D re.compile(r';f=3D[a-zA-Z0-9/-]*README;')
> -        master_branch =3D utils.get_branch('master')
> +        master_branch =3D utils.get_branch(settings.DEFAULT_BRANCH)
>          core_layer =3D None
>          with transaction.atomic():
>              for line in data.splitlines():
> diff --git a/layerindex/tools/update_classic_status.py
> b/layerindex/tools/update_classic_status.py
> index aa5d2ef..c8c373b 100755
> --- a/layerindex/tools/update_classic_status.py
> +++ b/layerindex/tools/update_classic_status.py
> @@ -83,6 +83,7 @@ def main():
>      args =3D parser.parse_args()
>
>      utils.setup_django()
> +    import settings
>      from layerindex.models import LayerItem, LayerBranch, Recipe,
> ClassicRecipe, Update, ComparisonRecipeUpdate
>      from django.db import transaction
>
> @@ -121,7 +122,7 @@ def main():
>      try:
>          with transaction.atomic():
>              def recipe_pn_query(pn):
> -                return
> Recipe.objects.filter(layerbranch__branch__name=3D'master').filter(pn=3Dp=
n).order_by('-layerbranch__layer__index_preference')
> +                return
> Recipe.objects.filter(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH=
).filter(pn=3Dpn).order_by('-layerbranch__layer__index_preference')
>
>              if args.import_data:
>                  recipequery =3D
> ClassicRecipe.objects.filter(layerbranch=3Dlayerbranch)
> @@ -141,9 +142,9 @@ def main():
>                          orig_layerbranch =3D recipe.cover_layerbranch
>                          recipe.cover_layerbranch =3D
> layerbranches.get(cover_layer, None)
>                          if recipe.cover_layerbranch is None:
> -                            recipe.cover_layerbranch =3D
> LayerBranch.objects.filter(branch__name=3D'master',
> layer__name=3Dcover_layer).first()
> +                            recipe.cover_layerbranch =3D
> LayerBranch.objects.filter(branch__name=3Dsettings.DEFAULT_BRANCH,
> layer__name=3Dcover_layer).first()
>                              if recipe.cover_layerbranch is None:
> -                                logger.warning('Could not find cover
> layer %s in master branch' % cover_layer)
> +                                logger.warning('Could not find cover
> layer %s in %s branch' % (cover_layer, settings.DEFAULT_BRANCH))
>                              else:
>                                  layerbranches[cover_layer] =3D
> recipe.cover_layerbranch
>                          if orig_layerbranch !=3D recipe.cover_layerbranc=
h:
> diff --git a/layerindex/update.py b/layerindex/update.py
> index df3939f..788daee 100755
> --- a/layerindex/update.py
> +++ b/layerindex/update.py
> @@ -333,7 +333,7 @@ def main():
>
>              # Get a safe bitbake branch to call into from this script
> (used later on)
>              safe_bitbake_branch =3D 'origin/master'
> -            master_branch =3D Branch.objects.filter(name=3D'master').fir=
st()
> +            master_branch =3D
> Branch.objects.filter(name=3Dsettings.DEFAULT_BRANCH).first()
>              if master_branch and master_branch.bitbake_branch:
>                  safe_bitbake_branch =3D 'origin/' +
> master_branch.bitbake_branch
>
> diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
> index 33c5cfb..6248f78 100644
> --- a/layerindex/update_layer.py
> +++ b/layerindex/update_layer.py
> @@ -250,7 +250,7 @@ def main():
>
>      parser.add_option("-b", "--branch",
>              help =3D "Specify branch to update",
> -            action=3D"store", dest=3D"branch", default=3D'master')
> +            action=3D"store", dest=3D"branch", default=3D'')
>      parser.add_option("-l", "--layer",
>              help =3D "Layer to update",
>              action=3D"store", dest=3D"layer")
> @@ -304,6 +304,8 @@ def main():
>
>      logger.setLevel(options.loglevel)
>
> +    if not options.branch:
> +        options.branch =3D settings.DEFAULT_BRANCH
>      branch =3D utils.get_branch(options.branch)
>      if not branch:
>          logger.error("Specified branch %s is not valid" % options.branch=
)
> diff --git a/layerindex/urls.py b/layerindex/urls.py
> index 51a832d..e7b0531 100644
> --- a/layerindex/urls.py
> +++ b/layerindex/urls.py
> @@ -20,6 +20,8 @@ from layerindex.views import LayerListView,
> LayerReviewListView, LayerReviewDeta
>  from layerindex.models import LayerItem, Recipe, RecipeChangeset
>  from rest_framework import routers
>  from . import restviews
> +import settings as _settings
> +_DEFAULT_BRANCH =3D getattr(_settings, 'DEFAULT_BRANCH', 'master')
>
>  router =3D routers.DefaultRouter()
>  router.register(r'branches', restviews.BranchViewSet)
> @@ -39,23 +41,23 @@ router.register(r'incFiles', restviews.IncFileViewSet=
)
>
>  urlpatterns =3D [
>      re_path(r'^$',
> -        RedirectView.as_view(url=3Dreverse_lazy('layer_list',
> args=3D('master',)), permanent=3DFalse),
> +        RedirectView.as_view(url=3Dreverse_lazy('layer_list',
> args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse),
>          name=3D'frontpage'),
>
>      re_path(r'^api/', include(router.urls)),
>
>      re_path(r'^layers/$',
> -        RedirectView.as_view(url=3Dreverse_lazy('layer_list',
> args=3D('master',)), permanent=3DFalse)),
> +        RedirectView.as_view(url=3Dreverse_lazy('layer_list',
> args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),
>      re_path(r'^layer/(?P<slug>[-\.\w]+)/$',
> -        RedirectParamsView.as_view(permanent=3DFalse), {'redirect_name':
> 'layer_item', 'branch': 'master'}),
> +        RedirectParamsView.as_view(permanent=3DFalse), {'redirect_name':
> 'layer_item', 'branch': _DEFAULT_BRANCH}),
>      re_path(r'^recipes/$',
> -        RedirectView.as_view(url=3Dreverse_lazy('recipe_search',
> args=3D('master',)), permanent=3DFalse)),
> +        RedirectView.as_view(url=3Dreverse_lazy('recipe_search',
> args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),
>      re_path(r'^machines/$',
> -        RedirectView.as_view(url=3Dreverse_lazy('machine_search',
> args=3D('master',)), permanent=3DFalse)),
> +        RedirectView.as_view(url=3Dreverse_lazy('machine_search',
> args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),
>      re_path(r'^distros/$',
> -        RedirectView.as_view(url=3Dreverse_lazy('distro_search',
> args=3D('master',)), permanent=3DFalse)),
> +        RedirectView.as_view(url=3Dreverse_lazy('distro_search',
> args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),
>      re_path(r'^classes/$',
> -        RedirectView.as_view(url=3Dreverse_lazy('class_search',
> args=3D('master',)), permanent=3DFalse)),
> +        RedirectView.as_view(url=3Dreverse_lazy('class_search',
> args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),
>      re_path(r'^submit/$', edit_layer_view, {'template_name':
> 'layerindex/submitlayer.html'}, name=3D"submit_layer"),
>      re_path(r'^submit/thanks/$',
>          TemplateView.as_view(
> diff --git a/layerindex/views.py b/layerindex/views.py
> index 84750f7..d3d8181 100644
> --- a/layerindex/views.py
> +++ b/layerindex/views.py
> @@ -114,7 +114,7 @@ def delete_layer_view(request, template_name, slug):
>          raise PermissionDenied
>      if request.method =3D=3D 'POST':
>          layeritem.delete()
> -        return HttpResponseRedirect(reverse('layer_list',
> args=3D('master',)))
> +        return HttpResponseRedirect(reverse('layer_list',
> args=3D(settings.DEFAULT_BRANCH,)))
>      else:
>          return render(request, template_name, {
>              'object': layeritem,
> @@ -122,7 +122,7 @@ def delete_layer_view(request, template_name, slug):
>              'cancel_url': layeritem.get_absolute_url()
>          })
>
> -def update_layer_view(request, template_name, branch=3D'master', slug=3D=
None):
> +def update_layer_view(request, template_name,
> branch=3Dsettings.DEFAULT_BRANCH, slug=3DNone):
>      if not (request.user.is_authenticated and request.user.is_staff):
>          raise PermissionDenied
>      return_url =3D None
> @@ -157,7 +157,7 @@ def update_layer_view(request, template_name,
> branch=3D'master', slug=3DNone):
>
>      return HttpResponseRedirect(reverse_lazy('task_status',
> kwargs=3D{'task_id': task_id}))
>
> -def edit_layer_view(request, template_name, branch=3D'master', slug=3DNo=
ne):
> +def edit_layer_view(request, template_name,
> branch=3Dsettings.DEFAULT_BRANCH, slug=3DNone):
>      return_url =3D None
>      branchobj =3D Branch.objects.filter(name=3Dbranch)[:1].get()
>      if slug:
> @@ -444,7 +444,7 @@ class LayerReviewListView(ListView):
>          return super(LayerReviewListView, self).dispatch(request, *args,
> **kwargs)
>
>      def get_queryset(self):
> -        return
> LayerBranch.objects.filter(branch__name=3D'master').filter(layer__status=
=3D'N').order_by('layer__name')
> +        return
> LayerBranch.objects.filter(branch__name=3Dsettings.DEFAULT_BRANCH).filter=
(layer__status=3D'N').order_by('layer__name')
>
>  class LayerDetailView(DetailView):
>      model =3D LayerItem
> @@ -492,7 +492,7 @@ class LayerReviewDetailView(LayerDetailView):
>          return super(LayerReviewDetailView, self).dispatch(request,
> *args, **kwargs)
>
>      def get_context_data(self, **kwargs):
> -        self.kwargs['branch'] =3D 'master'
> +        self.kwargs['branch'] =3D settings.DEFAULT_BRANCH
>          context =3D super(LayerReviewDetailView,
> self).get_context_data(**kwargs)
>          return context
>
> @@ -738,7 +738,7 @@ class AdvancedRecipeSearchView(ListView):
>                  query =3D Q(**{"%s__icontains" % field: value})
>              else:
>                  query =3D Q(**{"%s" % field: value})
> -            queryset =3D
> Recipe.objects.filter(layerbranch__branch__name=3D'master')
> +            queryset =3D
> Recipe.objects.filter(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH=
)
>              layer =3D self.request.GET.get('layer', '')
>              if layer:
>                  queryset =3D queryset.filter(layerbranch__layer=3Dlayer)
> @@ -825,7 +825,7 @@ class BulkChangeSearchView(AdvancedRecipeSearchView):
>      def get_context_data(self, **kwargs):
>          context =3D super(BulkChangeSearchView,
> self).get_context_data(**kwargs)
>          context['changeset'] =3D self.changeset
> -        context['current_branch'] =3D 'master'
> +        context['current_branch'] =3D settings.DEFAULT_BRANCH
>          return context
>
>
> @@ -1341,7 +1341,7 @@ class ClassicRecipeSearchView(RecipeSearchView):
>              filtered =3D True
>          qs, filtered =3D self.search_recipe_query(init_qs, query_string,
> preferred=3DFalse)
>          if qreversed:
> -            init_rqs =3D
> Recipe.objects.filter(layerbranch__branch__name=3D'master')
> +            init_rqs =3D
> Recipe.objects.filter(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH=
)
>              if layer_ids:
>                  init_rqs =3D
> init_rqs.filter(layerbranch__layer__id__in=3Dlayer_ids)
>              excludeclasses_param =3D self.request.GET.get('excludeclasse=
s',
> '')
> @@ -1735,7 +1735,7 @@ class
> ComparisonRecipeSelectView(ClassicRecipeSearchView):
>          return True
>
>      def get_context_data(self, **kwargs):
> -        self.kwargs['branch'] =3D 'master'
> +        self.kwargs['branch'] =3D settings.DEFAULT_BRANCH
>          context =3D super(ComparisonRecipeSelectView,
> self).get_context_data(**kwargs)
>          recipe =3D get_object_or_404(ClassicRecipe, pk=3Dself.kwargs['pk=
'])
>          context['select_for'] =3D recipe
> @@ -1761,7 +1761,7 @@ class
> ComparisonRecipeSelectView(ClassicRecipeSearchView):
>              layer_ids =3D [int(i) for i in selectedlayers_param.split(',=
')]
>          else:
>              layer_ids =3D []
> -        init_qs =3D
> Recipe.objects.filter(layerbranch__branch__name=3D'master')
> +        init_qs =3D
> Recipe.objects.filter(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH=
)
>          if layer_ids:
>              init_qs =3D init_qs.filter(layerbranch__layer__in=3Dlayer_id=
s)
>          qs, _ =3D self.search_recipe_query(init_qs, query_string,
> preferred=3DFalse)
> diff --git a/rrs/tools/historytool.py b/rrs/tools/historytool.py
> index 9f03ade..92e4b04 100755
> --- a/rrs/tools/historytool.py
> +++ b/rrs/tools/historytool.py
> @@ -77,7 +77,7 @@ def rrs_import(args):
>      if not core_layer:
>          logger.error('Unable to find core layer %s' %
> settings.CORE_LAYER_NAME)
>          return 1
> -    core_layerbranch =3D core_layer.get_layerbranch('master')
> +    core_layerbranch =3D core_layer.get_layerbranch(settings.DEFAULT_BRA=
NCH)
>      if not core_layerbranch:
>          logger.error('Unable to find branch master of layer %s' %
> core_layerbranch.name)
>          return 1
> @@ -130,7 +130,7 @@ def rrs_remove_duplicates(args):
>      if not core_layer:
>          logger.error('Unable to find core layer %s' %
> settings.CORE_LAYER_NAME)
>          return 1
> -    core_layerbranch =3D core_layer.get_layerbranch('master')
> +    core_layerbranch =3D core_layer.get_layerbranch(settings.DEFAULT_BRA=
NCH)
>      if not core_layerbranch:
>          logger.error('Unable to find branch master of layer %s' %
> core_layerbranch.name)
>          return 1
> diff --git a/settings.py b/settings.py
> index 94b3dd1..08004cb 100644
> --- a/settings.py
> +++ b/settings.py
> @@ -299,3 +299,6 @@ TASK_LOG_DIR =3D "/tmp/layerindex-task-logs"
>
>  # Full path to directory where rrs tools stores logs
>  TOOLS_LOG_DIR =3D ""
> +
> +# Default branch name used across the layer index
> +DEFAULT_BRANCH =3D 'master'
> --
> 2.43.0
>
>

--000000000000beebd6065503c13a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Sandeep,</div><div><br></div><div>Thank you for th=
e patch.</div><div><br></div><div>In the=C2=A0<span style=3D"background-col=
or:transparent">layerindex/update_layer.py you are updating the default val=
ue of `</span><span style=3D"background-color:transparent">--branch` to an =
empty string,</span></div><div><span style=3D"background-color:transparent"=
>which is inconsistent with the rest of the changes in this patch.</span></=
div><div><span style=3D"background-color:transparent"><br></span></div><div=
><span style=3D"background-color:transparent">In the same file, system sett=
ings are already imported at line 298, so perhaps that import should be mov=
ed above the parser logic</span></div><div><span style=3D"background-color:=
transparent">to</span><span style=3D"background-color:transparent">=C2=A0al=
low you to use `</span><span style=3D"background-color:transparent">setting=
s.DEFAULT_BRANCH` as a default value for the `--branch` option instead of a=
n empty string.</span></div><div><span style=3D"background-color:transparen=
t"><br></span></div><div><span style=3D"background-color:transparent">Best=
=C2=A0regards,</span></div><div><span style=3D"background-color:transparent=
">Piotr Buli=C5=84ski</span></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 19, 2026 at 1=
1:52=E2=80=AFPM Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlu=
pet-raju@amd.com">sandeep.gundlupet-raju@amd.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Replace all hardcoded branc=
h name references with settings.DEFAULT_BRANCH<br>
so the default branch can be changed from a single location in settings.py<=
br>
without modifying individual source files. DEFAULT_BRANCH defaults to &#39;=
master&#39;.<br>
<br>
- settings.py: add DEFAULT_BRANCH =3D &#39;master&#39;<br>
- docker/settings.py: add DEFAULT_BRANCH =3D &#39;master&#39;<br>
- layerindex/urls.py: use _DEFAULT_BRANCH from settings<br>
- layerindex/views.py: use settings.DEFAULT_BRANCH (10 occurrences)<br>
- layerindex/models.py: add import settings; use settings.DEFAULT_BRANCH<br=
>
- layerindex/update.py: use settings.DEFAULT_BRANCH<br>
- layerindex/update_layer.py: resolve branch from settings.DEFAULT_BRANCH<b=
r>
- layerindex/bulkchange.py: use settings.DEFAULT_BRANCH<br>
- layerindex/tools/import_layer.py: use settings.DEFAULT_BRANCH<br>
- layerindex/tools/import_wiki_layers.py: add import settings; use DEFAULT_=
BRANCH<br>
- layerindex/tools/import_classic_wiki.py: add import settings; use DEFAULT=
_BRANCH<br>
- layerindex/tools/update_classic_status.py: add import settings; use DEFAU=
LT_BRANCH<br>
- rrs/tools/historytool.py: use settings.DEFAULT_BRANCH<br>
<br>
AI-Generated: GitHub Copilot (Claude Sonnet 4.6)<br>
<br>
Signed-off-by: Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlup=
et-raju@amd.com" target=3D"_blank">sandeep.gundlupet-raju@amd.com</a>&gt;<b=
r>
---<br>
=C2=A0docker/settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0layerindex/bulkchange.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0layerindex/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++--<br>
=C2=A0layerindex/tools/import_classic_wiki.py=C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0layerindex/tools/import_layer.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 4 ++--<br>
=C2=A0layerindex/tools/import_wiki_layers.py=C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0layerindex/tools/update_classic_status.py |=C2=A0 7 ++++---<br>
=C2=A0layerindex/update.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0layerindex/update_layer.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0layerindex/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 +++++++++-------<br>
=C2=A0layerindex/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 ++++++++++----------<br>
=C2=A0rrs/tools/historytool.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A013 files changed, 44 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/docker/settings.py b/docker/settings.py<br>
index e3ae0fd..85b7efd 100644<br>
--- a/docker/settings.py<br>
+++ b/docker/settings.py<br>
@@ -315,3 +315,5 @@ SECURE_PROXY_SSL_HEADER =3D (&#39;HTTP_X_FORWARDED_PROT=
O&#39;, &#39;https&#39;)<br>
=C2=A0SECURE_BROWSER_XSS_FILTER =3D True<br>
=C2=A0SECURE_CONTENT_TYPE_NOSNIFF =3D True<br>
<br>
+# Default branch name used across the layer index<br>
+DEFAULT_BRANCH =3D &#39;master&#39;<br>
diff --git a/layerindex/bulkchange.py b/layerindex/bulkchange.py<br>
index 0ec4058..11cd7a6 100644<br>
--- a/layerindex/bulkchange.py<br>
+++ b/layerindex/bulkchange.py<br>
@@ -98,7 +98,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0utils.setup_django()<br>
=C2=A0 =C2=A0 =C2=A0import settings<br>
<br>
-=C2=A0 =C2=A0 branch =3D utils.get_branch(&#39;master&#39;)<br>
+=C2=A0 =C2=A0 branch =3D utils.get_branch(settings.DEFAULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0fetchdir =3D settings.LAYER_FETCH_DIR<br>
<br>
=C2=A0 =C2=A0 =C2=A0import layerindex.models import LayerItem<br>
diff --git a/layerindex/models.py b/layerindex/models.py<br>
index 864264b..7a09962 100644<br>
--- a/layerindex/models.py<br>
+++ b/layerindex/models.py<br>
@@ -18,6 +18,7 @@ import os.path<br>
=C2=A0import re<br>
=C2=A0import posixpath<br>
=C2=A0import codecs<br>
+import settings<br>
<br>
=C2=A0from . import utils<br>
<br>
@@ -190,7 +191,7 @@ class LayerItem(models.Model):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fetch_dir<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_absolute_url(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return reverse(&#39;layer_item&#39;, args=3D(&=
#39;master&#39;,<a href=3D"http://self.name" rel=3D"noreferrer" target=3D"_=
blank">self.name</a>));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return reverse(&#39;layer_item&#39;, args=3D(s=
ettings.DEFAULT_BRANCH,<a href=3D"http://self.name" rel=3D"noreferrer" targ=
et=3D"_blank">self.name</a>));<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __str__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return <a href=3D"http://self.name" rel=
=3D"noreferrer" target=3D"_blank">self.name</a><br>
@@ -672,7 +673,7 @@ class ClassicRecipe(Recipe):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;E&#39;, &#39;Equivalent functionali=
ty&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;D&#39;, &#39;Direct match&#39;),<br=
>
=C2=A0 =C2=A0 =C2=A0]<br>
-=C2=A0 =C2=A0 cover_layerbranch =3D models.ForeignKey(LayerBranch, verbose=
_name=3D&#39;Covering layer&#39;, blank=3DTrue, null=3DTrue, limit_choices_=
to =3D {&#39;branch__name&#39;: &#39;master&#39;}, on_delete=3Dmodels.SET_N=
ULL)<br>
+=C2=A0 =C2=A0 cover_layerbranch =3D models.ForeignKey(LayerBranch, verbose=
_name=3D&#39;Covering layer&#39;, blank=3DTrue, null=3DTrue, limit_choices_=
to =3D {&#39;branch__name&#39;: settings.DEFAULT_BRANCH}, on_delete=3Dmodel=
s.SET_NULL)<br>
=C2=A0 =C2=A0 =C2=A0cover_pn =3D models.CharField(&#39;Covering recipe&#39;=
, max_length=3D100, blank=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0cover_status =3D models.CharField(max_length=3D1, choic=
es=3DCOVER_STATUS_CHOICES, default=3D&#39;U&#39;)<br>
=C2=A0 =C2=A0 =C2=A0cover_verified =3D models.BooleanField(default=3DFalse)=
<br>
diff --git a/layerindex/tools/import_classic_wiki.py b/layerindex/tools/imp=
ort_classic_wiki.py<br>
index bd7ab9a..e8c4c8c 100755<br>
--- a/layerindex/tools/import_classic_wiki.py<br>
+++ b/layerindex/tools/import_classic_wiki.py<br>
@@ -84,6 +84,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0options, args =3D parser.parse_args(sys.argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0utils.setup_django()<br>
+=C2=A0 =C2=A0 import settings<br>
=C2=A0 =C2=A0 =C2=A0from layerindex.models import LayerItem, LayerBranch, R=
ecipe, ClassicRecipe<br>
=C2=A0 =C2=A0 =C2=A0from django.db import transaction<br>
<br>
@@ -178,7 +179,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D list(LayerItem.objects.filter(name=
=3Dnewlayer)[:1])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if res:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newlayeritem =3D res[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recipe.cover_layerbranch =3D newlaye=
ritem.get_layerbranch(&#39;master&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recipe.cover_layerbranch =3D newlaye=
ritem.get_layerbranch(settings.DEFAULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://logger.info"=
 rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&#39;Replacement laye=
r &quot;%s&quot; for %s could not be found&#39; % (newlayer, pn))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0recipe.cover_pn =3D newpn<br>
diff --git a/layerindex/tools/import_layer.py b/layerindex/tools/import_lay=
er.py<br>
index 79c679e..cdbd40d 100755<br>
--- a/layerindex/tools/import_layer.py<br>
+++ b/layerindex/tools/import_layer.py<br>
@@ -284,7 +284,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0if not os.path.exists(fetchdir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.makedirs(fetchdir)<br>
<br>
-=C2=A0 =C2=A0 master_branch =3D utils.get_branch(&#39;master&#39;)<br>
+=C2=A0 =C2=A0 master_branch =3D utils.get_branch(settings.DEFAULT_BRANCH)<=
br>
=C2=A0 =C2=A0 =C2=A0core_layer =3D None<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with transaction.atomic():<br>
@@ -311,7 +311,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(=
&quot;Fetch failed: %s&quot; % str(e))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<b=
r>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_branch =3D &#39;master&#3=
9;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_branch =3D settings.DEFAU=
LT_BRANCH<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options.actual_branch):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actual_branch=
 =3D options.actual_branch<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
diff --git a/layerindex/tools/import_wiki_layers.py b/layerindex/tools/impo=
rt_wiki_layers.py<br>
index 061f6df..f287bf6 100755<br>
--- a/layerindex/tools/import_wiki_layers.py<br>
+++ b/layerindex/tools/import_wiki_layers.py<br>
@@ -35,6 +35,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0options, args =3D parser.parse_args(sys.argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0utils.setup_django()<br>
+=C2=A0 =C2=A0 import settings<br>
=C2=A0 =C2=A0 =C2=A0from layerindex.models import LayerItem, LayerBranch, L=
ayerDependency<br>
=C2=A0 =C2=A0 =C2=A0from django.db import transaction<br>
<br>
@@ -49,7 +50,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nowiki_re =3D re.compile(r&#39;&lt;/?nowi=
ki&gt;&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_re =3D re.compile(r&#39;\[(http.*) +=
link\]&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readme_re =3D re.compile(r&#39;;f=3D[a-zA=
-Z0-9/-]*README;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 master_branch =3D utils.get_branch(&#39;master=
&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 master_branch =3D utils.get_branch(settings.DE=
FAULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0core_layer =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with transaction.atomic():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for line in data.splitlines=
():<br>
diff --git a/layerindex/tools/update_classic_status.py b/layerindex/tools/u=
pdate_classic_status.py<br>
index aa5d2ef..c8c373b 100755<br>
--- a/layerindex/tools/update_classic_status.py<br>
+++ b/layerindex/tools/update_classic_status.py<br>
@@ -83,6 +83,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0args =3D parser.parse_args()<br>
<br>
=C2=A0 =C2=A0 =C2=A0utils.setup_django()<br>
+=C2=A0 =C2=A0 import settings<br>
=C2=A0 =C2=A0 =C2=A0from layerindex.models import LayerItem, LayerBranch, R=
ecipe, ClassicRecipe, Update, ComparisonRecipeUpdate<br>
=C2=A0 =C2=A0 =C2=A0from django.db import transaction<br>
<br>
@@ -121,7 +122,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with transaction.atomic():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def recipe_pn_query(pn):<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return Recipe.obje=
cts.filter(layerbranch__branch__name=3D&#39;master&#39;).filter(pn=3Dpn).or=
der_by(&#39;-layerbranch__layer__index_preference&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return Recipe.obje=
cts.filter(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH).filter(pn=
=3Dpn).order_by(&#39;-layerbranch__layer__index_preference&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if args.import_data:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recipequery =
=3D ClassicRecipe.objects.filter(layerbranch=3Dlayerbranch)<br>
@@ -141,9 +142,9 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0orig_layerbranch =3D recipe.cover_layerbranch<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0recipe.cover_layerbranch =3D layerbranches.get(cover_layer=
, None)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if recipe.cover_layerbranch is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 recipe.cover_layerbranch =3D LayerBranch.objects.f=
ilter(branch__name=3D&#39;master&#39;, layer__name=3Dcover_layer).first()<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 recipe.cover_layerbranch =3D LayerBranch.objects.f=
ilter(branch__name=3Dsettings.DEFAULT_BRANCH, layer__name=3Dcover_layer).fi=
rst()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if recipe.cover_layerbranch is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.warning(&#39;Could not find c=
over layer %s in master branch&#39; % cover_layer)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.warning(&#39;Could not find c=
over layer %s in %s branch&#39; % (cover_layer, settings.DEFAULT_BRANCH))<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layerbranches[cover_layer] =3D=
 recipe.cover_layerbranch<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if orig_layerbranch !=3D recipe.cover_layerbranch:<br>
diff --git a/layerindex/update.py b/layerindex/update.py<br>
index df3939f..788daee 100755<br>
--- a/layerindex/update.py<br>
+++ b/layerindex/update.py<br>
@@ -333,7 +333,7 @@ def main():<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Get a safe bitbake branch=
 to call into from this script (used later on)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0safe_bitbake_branch =3D &#3=
9;origin/master&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 master_branch =3D Branch.objects=
.filter(name=3D&#39;master&#39;).first()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 master_branch =3D Branch.objects=
.filter(name=3Dsettings.DEFAULT_BRANCH).first()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if master_branch and master=
_branch.bitbake_branch:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0safe_bitbake_=
branch =3D &#39;origin/&#39; + master_branch.bitbake_branch<br>
<br>
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py<br>
index 33c5cfb..6248f78 100644<br>
--- a/layerindex/update_layer.py<br>
+++ b/layerindex/update_layer.py<br>
@@ -250,7 +250,7 @@ def main():<br>
<br>
=C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;-b&quot;, &quot;--branch&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help =3D &quot;Specify bran=
ch to update&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store&quot;, dest=
=3D&quot;branch&quot;, default=3D&#39;master&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store&quot;, dest=
=3D&quot;branch&quot;, default=3D&#39;&#39;)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;-l&quot;, &quot;--layer&quot;,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help =3D &quot;Layer to upd=
ate&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0action=3D&quot;store&quot;,=
 dest=3D&quot;layer&quot;)<br>
@@ -304,6 +304,8 @@ def main():<br>
<br>
=C2=A0 =C2=A0 =C2=A0logger.setLevel(options.loglevel)<br>
<br>
+=C2=A0 =C2=A0 if not options.branch:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options.branch =3D settings.DEFAULT_BRANCH<br>
=C2=A0 =C2=A0 =C2=A0branch =3D utils.get_branch(options.branch)<br>
=C2=A0 =C2=A0 =C2=A0if not branch:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(&quot;Specified branch %s is=
 not valid&quot; % options.branch)<br>
diff --git a/layerindex/urls.py b/layerindex/urls.py<br>
index 51a832d..e7b0531 100644<br>
--- a/layerindex/urls.py<br>
+++ b/layerindex/urls.py<br>
@@ -20,6 +20,8 @@ from layerindex.views import LayerListView, LayerReviewLi=
stView, LayerReviewDeta<br>
=C2=A0from layerindex.models import LayerItem, Recipe, RecipeChangeset<br>
=C2=A0from rest_framework import routers<br>
=C2=A0from . import restviews<br>
+import settings as _settings<br>
+_DEFAULT_BRANCH =3D getattr(_settings, &#39;DEFAULT_BRANCH&#39;, &#39;mast=
er&#39;)<br>
<br>
=C2=A0router =3D routers.DefaultRouter()<br>
=C2=A0router.register(r&#39;branches&#39;, restviews.BranchViewSet)<br>
@@ -39,23 +41,23 @@ router.register(r&#39;incFiles&#39;, restviews.IncFileV=
iewSet)<br>
<br>
=C2=A0urlpatterns =3D [<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^$&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;l=
ayer_list&#39;, args=3D(&#39;master&#39;,)), permanent=3DFalse),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;l=
ayer_list&#39;, args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name=3D&#39;frontpage&#39;),<br>
<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^api/&#39;, include(router.urls)),<br>
<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^layers/$&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;l=
ayer_list&#39;, args=3D(&#39;master&#39;,)), permanent=3DFalse)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;l=
ayer_list&#39;, args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^layer/(?P&lt;slug&gt;[-\.\w]+)/$&#39;,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectParamsView.as_view(permanent=3DFalse),=
 {&#39;redirect_name&#39;: &#39;layer_item&#39;, &#39;branch&#39;: &#39;mas=
ter&#39;}),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectParamsView.as_view(permanent=3DFalse),=
 {&#39;redirect_name&#39;: &#39;layer_item&#39;, &#39;branch&#39;: _DEFAULT=
_BRANCH}),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^recipes/$&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;r=
ecipe_search&#39;, args=3D(&#39;master&#39;,)), permanent=3DFalse)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;r=
ecipe_search&#39;, args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^machines/$&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;m=
achine_search&#39;, args=3D(&#39;master&#39;,)), permanent=3DFalse)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;m=
achine_search&#39;, args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^distros/$&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;d=
istro_search&#39;, args=3D(&#39;master&#39;,)), permanent=3DFalse)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;d=
istro_search&#39;, args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^classes/$&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;c=
lass_search&#39;, args=3D(&#39;master&#39;,)), permanent=3DFalse)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RedirectView.as_view(url=3Dreverse_lazy(&#39;c=
lass_search&#39;, args=3D(_DEFAULT_BRANCH,)), permanent=3DFalse)),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^submit/$&#39;, edit_layer_view, {&#39;te=
mplate_name&#39;: &#39;layerindex/submitlayer.html&#39;}, name=3D&quot;subm=
it_layer&quot;),<br>
=C2=A0 =C2=A0 =C2=A0re_path(r&#39;^submit/thanks/$&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TemplateView.as_view(<br>
diff --git a/layerindex/views.py b/layerindex/views.py<br>
index 84750f7..d3d8181 100644<br>
--- a/layerindex/views.py<br>
+++ b/layerindex/views.py<br>
@@ -114,7 +114,7 @@ def delete_layer_view(request, template_name, slug):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise PermissionDenied<br>
=C2=A0 =C2=A0 =C2=A0if request.method =3D=3D &#39;POST&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layeritem.delete()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return HttpResponseRedirect(reverse(&#39;layer=
_list&#39;, args=3D(&#39;master&#39;,)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return HttpResponseRedirect(reverse(&#39;layer=
_list&#39;, args=3D(settings.DEFAULT_BRANCH,)))<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return render(request, template_name, {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;object&#39;: layeritem=
,<br>
@@ -122,7 +122,7 @@ def delete_layer_view(request, template_name, slug):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cancel_url&#39;: layer=
item.get_absolute_url()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0})<br>
<br>
-def update_layer_view(request, template_name, branch=3D&#39;master&#39;, s=
lug=3DNone):<br>
+def update_layer_view(request, template_name, branch=3Dsettings.DEFAULT_BR=
ANCH, slug=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0if not (request.user.is_authenticated and request.user.=
is_staff):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise PermissionDenied<br>
=C2=A0 =C2=A0 =C2=A0return_url =3D None<br>
@@ -157,7 +157,7 @@ def update_layer_view(request, template_name, branch=3D=
&#39;master&#39;, slug=3DNone):<br>
<br>
=C2=A0 =C2=A0 =C2=A0return HttpResponseRedirect(reverse_lazy(&#39;task_stat=
us&#39;, kwargs=3D{&#39;task_id&#39;: task_id}))<br>
<br>
-def edit_layer_view(request, template_name, branch=3D&#39;master&#39;, slu=
g=3DNone):<br>
+def edit_layer_view(request, template_name, branch=3Dsettings.DEFAULT_BRAN=
CH, slug=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0return_url =3D None<br>
=C2=A0 =C2=A0 =C2=A0branchobj =3D Branch.objects.filter(name=3Dbranch)[:1].=
get()<br>
=C2=A0 =C2=A0 =C2=A0if slug:<br>
@@ -444,7 +444,7 @@ class LayerReviewListView(ListView):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return super(LayerReviewListView, self).d=
ispatch(request, *args, **kwargs)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_queryset(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return LayerBranch.objects.filter(branch__name=
=3D&#39;master&#39;).filter(layer__status=3D&#39;N&#39;).order_by(&#39;laye=
r__name&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return LayerBranch.objects.filter(branch__name=
=3Dsettings.DEFAULT_BRANCH).filter(layer__status=3D&#39;N&#39;).order_by(&#=
39;layer__name&#39;)<br>
<br>
=C2=A0class LayerDetailView(DetailView):<br>
=C2=A0 =C2=A0 =C2=A0model =3D LayerItem<br>
@@ -492,7 +492,7 @@ class LayerReviewDetailView(LayerDetailView):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return super(LayerReviewDetailView, self)=
.dispatch(request, *args, **kwargs)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_context_data(self, **kwargs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kwargs[&#39;branch&#39;] =3D &#39;master&=
#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kwargs[&#39;branch&#39;] =3D settings.DEF=
AULT_BRANCH<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context =3D super(LayerReviewDetailView, =
self).get_context_data(**kwargs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return context<br>
<br>
@@ -738,7 +738,7 @@ class AdvancedRecipeSearchView(ListView):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query =3D Q(*=
*{&quot;%s__icontains&quot; % field: value})<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query =3D Q(*=
*{&quot;%s&quot; % field: value})<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queryset =3D Recipe.objects.filt=
er(layerbranch__branch__name=3D&#39;master&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queryset =3D Recipe.objects.filt=
er(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer =3D self.request.GET.=
get(&#39;layer&#39;, &#39;&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if layer:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queryset =3D =
queryset.filter(layerbranch__layer=3Dlayer)<br>
@@ -825,7 +825,7 @@ class BulkChangeSearchView(AdvancedRecipeSearchView):<b=
r>
=C2=A0 =C2=A0 =C2=A0def get_context_data(self, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context =3D super(BulkChangeSearchView, s=
elf).get_context_data(**kwargs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context[&#39;changeset&#39;] =3D self.cha=
ngeset<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 context[&#39;current_branch&#39;] =3D &#39;mas=
ter&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 context[&#39;current_branch&#39;] =3D settings=
.DEFAULT_BRANCH<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return context<br>
<br>
<br>
@@ -1341,7 +1341,7 @@ class ClassicRecipeSearchView(RecipeSearchView):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filtered =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qs, filtered =3D self.search_recipe_query=
(init_qs, query_string, preferred=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if qreversed:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_rqs =3D Recipe.objects.filt=
er(layerbranch__branch__name=3D&#39;master&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_rqs =3D Recipe.objects.filt=
er(layerbranch__branch__name=3Dsettings.DEFAULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if layer_ids:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_rqs =3D =
init_rqs.filter(layerbranch__layer__id__in=3Dlayer_ids)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0excludeclasses_param =3D se=
lf.request.GET.get(&#39;excludeclasses&#39;, &#39;&#39;)<br>
@@ -1735,7 +1735,7 @@ class ComparisonRecipeSelectView(ClassicRecipeSearchV=
iew):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_context_data(self, **kwargs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kwargs[&#39;branch&#39;] =3D &#39;master&=
#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kwargs[&#39;branch&#39;] =3D settings.DEF=
AULT_BRANCH<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context =3D super(ComparisonRecipeSelectV=
iew, self).get_context_data(**kwargs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recipe =3D get_object_or_404(ClassicRecip=
e, pk=3Dself.kwargs[&#39;pk&#39;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context[&#39;select_for&#39;] =3D recipe<=
br>
@@ -1761,7 +1761,7 @@ class ComparisonRecipeSelectView(ClassicRecipeSearchV=
iew):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_ids =3D [int(i) for i=
 in selectedlayers_param.split(&#39;,&#39;)]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_ids =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 init_qs =3D Recipe.objects.filter(layerbranch_=
_branch__name=3D&#39;master&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 init_qs =3D Recipe.objects.filter(layerbranch_=
_branch__name=3Dsettings.DEFAULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if layer_ids:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_qs =3D init_qs.filter(=
layerbranch__layer__in=3Dlayer_ids)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qs, _ =3D self.search_recipe_query(init_q=
s, query_string, preferred=3DFalse)<br>
diff --git a/rrs/tools/historytool.py b/rrs/tools/historytool.py<br>
index 9f03ade..92e4b04 100755<br>
--- a/rrs/tools/historytool.py<br>
+++ b/rrs/tools/historytool.py<br>
@@ -77,7 +77,7 @@ def rrs_import(args):<br>
=C2=A0 =C2=A0 =C2=A0if not core_layer:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(&#39;Unable to find core lay=
er %s&#39; % settings.CORE_LAYER_NAME)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-=C2=A0 =C2=A0 core_layerbranch =3D core_layer.get_layerbranch(&#39;master&=
#39;)<br>
+=C2=A0 =C2=A0 core_layerbranch =3D core_layer.get_layerbranch(settings.DEF=
AULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0if not core_layerbranch:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(&#39;Unable to find branch m=
aster of layer %s&#39; % <a href=3D"http://core_layerbranch.name" rel=3D"no=
referrer" target=3D"_blank">core_layerbranch.name</a>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
@@ -130,7 +130,7 @@ def rrs_remove_duplicates(args):<br>
=C2=A0 =C2=A0 =C2=A0if not core_layer:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(&#39;Unable to find core lay=
er %s&#39; % settings.CORE_LAYER_NAME)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-=C2=A0 =C2=A0 core_layerbranch =3D core_layer.get_layerbranch(&#39;master&=
#39;)<br>
+=C2=A0 =C2=A0 core_layerbranch =3D core_layer.get_layerbranch(settings.DEF=
AULT_BRANCH)<br>
=C2=A0 =C2=A0 =C2=A0if not core_layerbranch:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(&#39;Unable to find branch m=
aster of layer %s&#39; % <a href=3D"http://core_layerbranch.name" rel=3D"no=
referrer" target=3D"_blank">core_layerbranch.name</a>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
diff --git a/settings.py b/settings.py<br>
index 94b3dd1..08004cb 100644<br>
--- a/settings.py<br>
+++ b/settings.py<br>
@@ -299,3 +299,6 @@ TASK_LOG_DIR =3D &quot;/tmp/layerindex-task-logs&quot;<=
br>
<br>
=C2=A0# Full path to directory where rrs tools stores logs<br>
=C2=A0TOOLS_LOG_DIR =3D &quot;&quot;<br>
+<br>
+# Default branch name used across the layer index<br>
+DEFAULT_BRANCH =3D &#39;master&#39;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000beebd6065503c13a--

