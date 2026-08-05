Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04AAC55ABA
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 16:12:43 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43807.1785946361248051444
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 09:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=RypUA+bn;
 spf=pass (domain: qbee.io, ip: 209.85.167.48, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec6360133so1072988e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1785946359; x=1786551159; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chrh0jPaIGgi009ClImqlilV9mVgIpPrygWjLWBFY3M=;
        b=RypUA+bnHAcguQYRnpq7zrBBeSmuvW/k59CpKircwPzd4Njj2c8BXg/mVvdh4KcARr
         f0jwSww7iLcJccjpvzQ8i4PhLSkJjnMoSt+pU/VXiJ5vd0yvSwzctLQo9zqfzTxK0KxI
         YKRFQFf2aUE2aGoItG117RltQy81rXgfRxEAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946359; x=1786551159;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=chrh0jPaIGgi009ClImqlilV9mVgIpPrygWjLWBFY3M=;
        b=BT5znoTrjIUsN8MxiBseI6AEdUiTdUkR3pmz6lWpTg5aVuO2DeW6wI0qqvw4Jm9Fsp
         FOo9H17UivFGCTJH0du4pvxaCQXJx0xSte4cTbszcCOrORWXox1j0RALT06WhHyuZfcR
         D0oZniu8dPW+dfbl5CNy0a8ZKNXCGApJwn69AXHEsM5HUrm6NwBAwl9MDQVBAuU5rMFo
         rYs1wvvbuSsoPy87FD/Q2JUMmkirfne4wYEMKa2tcre1xIle4ARhsG3INF6G319z6vvg
         ex+7EDDVW8K2W3CO49NwewMUVC+O7mI5F2VBoqZVpfVAxgK72vjP13siFwXooZVSN7kz
         AzbA==
X-Gm-Message-State: AOJu0Yyd7ONlRsOXPPgKOuMqKcylRDQs9Qa2dPUfBCmh4IauW4ArBg47
	prfuU5fyg6lQsfTTtUvmCrBXWIHp4COidyxYHcs0s4UEEsbx8L+w5BQKVLJmy9X3Z687n5sJQXG
	afvshZyo=
X-Gm-Gg: AR+sD11WNvpuIWWKD2UOi+hmgJBay92QffEu+f0h+cNZ9r9TAIqkd3wqEOAZq2et8wW
	XRat3y0p6h4BsJ8DS3gTCCNrJ2MaGSU+aedg0CFqtktTlG215Yg1wACb0swj6hpOrLudSc6PSfs
	jACQvqdHfQUiI15dkdJ5Qq+Q8xZuxQeWKaz6Jo6TisdPi+2lXou52XWs8HmL/kLCM81B6NaJ09o
	1Z22FX8SZjfNUUoEB74ykPrm3lB1yK1V9cxamj4r2ajpWKbchi4x1opP0zGAqfab//HkViDvul3
	2omfKBMTVfOD0SrWRnrwSpqxwX3+AcPKRaUV4BJwWOKvIzxT7jyJcsMDFODeTfY7neOjAD/Pj7l
	V3OMER3BTzKOAxW1b6cb0TkL9ejhCPBWeVkhScmAbnlxN8lHL86OQiKguh3qlTI2FTz3Dxi23DB
	IO6Q9xIDTlL3VzafmaxDGcUvi89qSmUTo6XnoBsaa27XeDxpMqcUd8NXZOyDmWH838trcJ/GcOs
	E/Xe/O8prXQmRjFtQ==
X-Received: by 2002:a05:6512:3e0d:b0:5b0:1dd0:f226 with SMTP id 2adb3069b0e04-5b2f4cd761cmr1351159e87.49.1785946358627;
        Wed, 05 Aug 2026 09:12:38 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5b2f623d669sm209604e87.18.2026.08.05.09.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:12:37 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Update Django settings import to use the correct form.
Date: Wed,  5 Aug 2026 18:12:34 +0200
Message-ID: <20260805161234.50966-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 16:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4636

Per Django documentation [1] it should use the following form:

`from django.conf import settings`

not:

`import settings`

In few files the settings are not even used, so the import is removed.

Bugzilla issue: https://bugzilla.yoctoproject.org/show_bug.cgi?id=16331

[1] - https://docs.djangoproject.com/en/6.0/topics/settings/#using-settings-in-python-code

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 layerindex/auth_forms.py                         | 2 +-
 layerindex/auth_views.py                         | 2 +-
 layerindex/bulkchange.py                         | 2 +-
 layerindex/context_processors.py                 | 2 +-
 layerindex/forms.py                              | 2 +-
 layerindex/layerconfparse.py                     | 2 +-
 layerindex/middleware.py                         | 2 --
 layerindex/recipedesc.py                         | 1 -
 layerindex/tasks.py                              | 4 ++--
 layerindex/tools/fixup_duplicates.py             | 1 -
 layerindex/tools/import_classic.py               | 2 +-
 layerindex/tools/import_layer.py                 | 2 +-
 layerindex/tools/import_otherdistro.py           | 6 +++---
 layerindex/tools/import_project.py               | 2 +-
 layerindex/tools/mark_yp_compatible_layers.py    | 1 -
 layerindex/update.py                             | 2 +-
 layerindex/update_layer.py                       | 2 +-
 layerindex/utils.py                              | 2 +-
 layerindex/views.py                              | 2 +-
 rrs/context_processors.py                        | 2 +-
 rrs/migrations/0004_maint_plan_default.py        | 2 +-
 rrs/migrations/0013_reup_layerbranch_populate.py | 2 +-
 rrs/migrations/0015_rmh_layerbranch_populate.py  | 2 +-
 rrs/tools/dump_upgrades.py                       | 2 +-
 rrs/tools/historytool.py                         | 6 +++---
 rrs/tools/rrs_distros.py                         | 2 +-
 rrs/tools/rrs_maintainer_history.py              | 2 +-
 rrs/tools/rrs_upgrade_history.py                 | 2 +-
 rrs/tools/rrs_upstream_email.py                  | 2 +-
 rrs/tools/rrs_upstream_history.py                | 2 +-
 rrs/tools/upgrade_history_internal.py            | 2 +-
 urls.py                                          | 2 +-
 32 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/layerindex/auth_forms.py b/layerindex/auth_forms.py
index 7af48f9..e4b9183 100644
--- a/layerindex/auth_forms.py
+++ b/layerindex/auth_forms.py
@@ -14,7 +14,7 @@ from django.contrib.auth.models import User
 from django_registration.forms import RegistrationForm
 
 from layerindex.models import SecurityQuestion, UserProfile
-import settings
+from django.conf import settings
 
 
 class CaptchaRegistrationForm(RegistrationForm):
diff --git a/layerindex/auth_views.py b/layerindex/auth_views.py
index 08e0334..3603d1c 100644
--- a/layerindex/auth_views.py
+++ b/layerindex/auth_views.py
@@ -28,7 +28,7 @@ from layerindex.auth_forms import (CaptchaPasswordResetForm,
 
 from .models import SecurityQuestion, SecurityQuestionAnswer, UserProfile
 from . import tasks
-import settings
+from django.conf import settings
 
 @method_decorator(never_cache, name='dispatch')
 class CaptchaRegistrationView(RegistrationView):
diff --git a/layerindex/bulkchange.py b/layerindex/bulkchange.py
index 0ec4058..d2ac1f4 100644
--- a/layerindex/bulkchange.py
+++ b/layerindex/bulkchange.py
@@ -96,7 +96,7 @@ def main():
         sys.exit(1)
 
     utils.setup_django()
-    import settings
+    from django.conf import settings
 
     branch = utils.get_branch('master')
     fetchdir = settings.LAYER_FETCH_DIR
diff --git a/layerindex/context_processors.py b/layerindex/context_processors.py
index 2cc0380..2d6beab 100644
--- a/layerindex/context_processors.py
+++ b/layerindex/context_processors.py
@@ -12,7 +12,7 @@ from django.db.models import Q
 from datetime import datetime
 
 def layerindex_context(request):
-    import settings
+    from django.conf import settings
     site = Site.objects.get_current()
     if site and site.name and site.name != 'example.com':
         site_name = site.name
diff --git a/layerindex/forms.py b/layerindex/forms.py
index 360af40..b0ffc31 100644
--- a/layerindex/forms.py
+++ b/layerindex/forms.py
@@ -20,7 +20,7 @@ from django_registration.validators import (DEFAULT_RESERVED_NAMES,
                                             ReservedNameValidator,
                                             validate_confusables)
 
-import settings
+from django.conf import settings
 from layerindex.models import (Branch, ClassicRecipe,
                                LayerBranch, LayerItem, LayerMaintainer,
                                LayerNote, RecipeChange, RecipeChangeset,
diff --git a/layerindex/layerconfparse.py b/layerindex/layerconfparse.py
index 84ec005..abcb1b6 100644
--- a/layerindex/layerconfparse.py
+++ b/layerindex/layerconfparse.py
@@ -16,7 +16,7 @@ import re
 
 class LayerConfParse:
     def __init__(self, enable_tracking=False, logger=None, bitbakepath=None, tinfoil=None):
-        import settings
+        from django.conf import settings
         self.logger = logger
 
         if not bitbakepath:
diff --git a/layerindex/middleware.py b/layerindex/middleware.py
index 527cc8b..6766b1d 100644
--- a/layerindex/middleware.py
+++ b/layerindex/middleware.py
@@ -10,8 +10,6 @@ from django.utils.deprecation import MiddlewareMixin
 from django.http import HttpResponseRedirect
 from django.urls import reverse
 from reversion.middleware import RevisionMiddleware
-import settings
-import re
 
 class NonAtomicRevisionMiddleware(RevisionMiddleware):
     atomic = False
diff --git a/layerindex/recipedesc.py b/layerindex/recipedesc.py
index 8cbdcf0..9430a2a 100644
--- a/layerindex/recipedesc.py
+++ b/layerindex/recipedesc.py
@@ -37,7 +37,6 @@ def main():
     from django.conf import settings
     from layerindex.models import LayerItem, Recipe
     from django.db import transaction
-    import settings
     from layerindex.utils import is_commit_ancestor
 
     setup_environ(settings)
diff --git a/layerindex/tasks.py b/layerindex/tasks.py
index da85539..4af9466 100644
--- a/layerindex/tasks.py
+++ b/layerindex/tasks.py
@@ -17,12 +17,12 @@ import shlex
 from datetime import datetime
 
 try:
-    import settings
+    from django.conf import settings
 except ImportError:
     # not in a full django env, so settings is inaccessible.
     # setup django to access settings.
     utils.setup_django()
-    import settings
+    from django.conf import settings
 
 tasks = Celery('layerindex',
     broker=settings.RABBIT_BROKER,
diff --git a/layerindex/tools/fixup_duplicates.py b/layerindex/tools/fixup_duplicates.py
index 6c60959..d0c0786 100644
--- a/layerindex/tools/fixup_duplicates.py
+++ b/layerindex/tools/fixup_duplicates.py
@@ -44,7 +44,6 @@ def main():
     options, args = parser.parse_args(sys.argv)
 
     utils.setup_django()
-    import settings
     from layerindex.models import Recipe
     from django.db import transaction
 
diff --git a/layerindex/tools/import_classic.py b/layerindex/tools/import_classic.py
index 07565ac..ef41494 100755
--- a/layerindex/tools/import_classic.py
+++ b/layerindex/tools/import_classic.py
@@ -95,7 +95,7 @@ def main():
         sys.exit(1)
 
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import LayerItem, LayerBranch, Recipe, ClassicRecipe, Machine, BBAppend, BBClass
     from django.db import transaction
 
diff --git a/layerindex/tools/import_layer.py b/layerindex/tools/import_layer.py
index 79c679e..0b203c3 100755
--- a/layerindex/tools/import_layer.py
+++ b/layerindex/tools/import_layer.py
@@ -270,7 +270,7 @@ def main():
         github_login = None
         github_password = None
 
-    import settings
+    from django.conf import settings
     from layerindex.models import LayerItem, LayerBranch, LayerDependency, LayerMaintainer
     from django.db import transaction
 
diff --git a/layerindex/tools/import_otherdistro.py b/layerindex/tools/import_otherdistro.py
index 5c00115..f6ee395 100755
--- a/layerindex/tools/import_otherdistro.py
+++ b/layerindex/tools/import_otherdistro.py
@@ -533,7 +533,7 @@ def import_specfiles(specfiles, layerbranch, existing, updateobj, reldir):
 
 def import_pkgspec(args):
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import LayerItem, LayerBranch, Recipe, ClassicRecipe, Machine, BBAppend, BBClass, ComparisonRecipeUpdate
     from django.db import transaction
 
@@ -595,7 +595,7 @@ def import_pkgspec(args):
 
 def try_specfile(args):
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import LayerItem, LayerBranch, Recipe, ClassicRecipe, Machine, BBAppend, BBClass
     from django.db import transaction
 
@@ -642,7 +642,7 @@ def try_specfile(args):
 
 def import_deblist(args):
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import LayerItem, LayerBranch, Recipe, ClassicRecipe, Machine, BBAppend, BBClass
     from django.db import transaction
 
diff --git a/layerindex/tools/import_project.py b/layerindex/tools/import_project.py
index 44cf6cc..bad79b0 100755
--- a/layerindex/tools/import_project.py
+++ b/layerindex/tools/import_project.py
@@ -160,7 +160,7 @@ class ImportProject:
     def add_core(self, layers):
         utils.setup_django()
         core = None
-        import settings
+        from django.conf import settings
         for layer in layers:
             layer_name = self.get_layer_name(layer)
             if layer_name == settings.CORE_LAYER_NAME:
diff --git a/layerindex/tools/mark_yp_compatible_layers.py b/layerindex/tools/mark_yp_compatible_layers.py
index 1d2dc32..39e3b54 100755
--- a/layerindex/tools/mark_yp_compatible_layers.py
+++ b/layerindex/tools/mark_yp_compatible_layers.py
@@ -72,7 +72,6 @@ def main():
     args = parser.parse_args()
 
     utils.setup_django()
-    import settings
     from layerindex.models import Branch, LayerBranch, LayerItem, YPCompatibleVersion
     from django.db import transaction
 
diff --git a/layerindex/update.py b/layerindex/update.py
index df3939f..dd730ca 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -194,7 +194,7 @@ def main():
         sys.exit(1)
 
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import Branch, LayerItem, Update, LayerUpdate, LayerBranch
 
     logger.setLevel(options.loglevel)
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 33c5cfb..d150b8f 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -295,7 +295,7 @@ def main():
         options.reload = True
 
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from layerindex.models import (LayerItem, LayerBranch, LayerDependency,
                                    Recipe, RecipeFileDependency, Machine,
                                    Distro, BBAppend, BBClass,
diff --git a/layerindex/utils.py b/layerindex/utils.py
index 66e4994..6c0ad8f 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -186,7 +186,7 @@ def _add_dependency(var, name, layerbranch, config_data, logger=None, required=T
         layerdep.save()
 
     if need_remove:
-        import settings
+        from django.conf import settings
         remove_layer_dependencies = getattr(settings, 'REMOVE_LAYER_DEPENDENCIES', False)
         if remove_layer_dependencies:
             logger.info('Removing obsolete dependencies "%s" for layer %s' % (need_remove, layer_name))
diff --git a/layerindex/views.py b/layerindex/views.py
index 84750f7..c671cc5 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -43,7 +43,7 @@ from django.views.generic.edit import (CreateView, DeleteView, FormView,
 from django_registration.backends.activation.views import RegistrationView
 from reversion.models import Revision
 
-import settings
+from django.conf import settings
 from layerindex.forms import (AdvancedRecipeSearchForm, BulkChangeEditFormSet,
                               ClassicRecipeForm, ClassicRecipeSearchForm,
                               ComparisonRecipeSelectForm, EditLayerForm,
diff --git a/rrs/context_processors.py b/rrs/context_processors.py
index 52e2c30..a48d33a 100644
--- a/rrs/context_processors.py
+++ b/rrs/context_processors.py
@@ -6,7 +6,7 @@
 #
 # SPDX-License-Identifier: MIT
 
-import settings
+from django.conf import settings
 from django.contrib.sites.models import Site
 
 def rrs_context(request):
diff --git a/rrs/migrations/0004_maint_plan_default.py b/rrs/migrations/0004_maint_plan_default.py
index 1d192d0..6606e2b 100644
--- a/rrs/migrations/0004_maint_plan_default.py
+++ b/rrs/migrations/0004_maint_plan_default.py
@@ -2,7 +2,7 @@
 from __future__ import unicode_literals
 
 from django.db import migrations, models
-import settings
+from django.conf import settings
 
 
 def populate_plan(apps, schema_editor):
diff --git a/rrs/migrations/0013_reup_layerbranch_populate.py b/rrs/migrations/0013_reup_layerbranch_populate.py
index f5e88a7..cc3b3b3 100644
--- a/rrs/migrations/0013_reup_layerbranch_populate.py
+++ b/rrs/migrations/0013_reup_layerbranch_populate.py
@@ -2,7 +2,7 @@
 from __future__ import unicode_literals
 
 from django.db import migrations, models
-import settings
+from django.conf import settings
 
 
 def populate_layerbranch(apps, schema_editor):
diff --git a/rrs/migrations/0015_rmh_layerbranch_populate.py b/rrs/migrations/0015_rmh_layerbranch_populate.py
index 5c3d5e3..2ef3eb3 100644
--- a/rrs/migrations/0015_rmh_layerbranch_populate.py
+++ b/rrs/migrations/0015_rmh_layerbranch_populate.py
@@ -2,7 +2,7 @@
 from __future__ import unicode_literals
 
 from django.db import migrations, models
-import settings
+from django.conf import settings
 
 
 def populate_rmh_layerbranch(apps, schema_editor):
diff --git a/rrs/tools/dump_upgrades.py b/rrs/tools/dump_upgrades.py
index 982f5a3..afee53b 100755
--- a/rrs/tools/dump_upgrades.py
+++ b/rrs/tools/dump_upgrades.py
@@ -47,7 +47,7 @@ def main():
         loglevel = logging.INFO
 
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from rrs.models import MaintenancePlan, Release, Milestone, RecipeUpgrade, RecipeSymbol
     import rrs.views
     from django.db import transaction
diff --git a/rrs/tools/historytool.py b/rrs/tools/historytool.py
index 9f03ade..93b2522 100755
--- a/rrs/tools/historytool.py
+++ b/rrs/tools/historytool.py
@@ -30,7 +30,7 @@ logger = utils.logger_create('RrsExport')
 
 def rrs_export(args):
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from rrs.models import RecipeUpstreamHistory, RecipeUpstream
 
     class DatetimeEncoder(json.JSONEncoder):
@@ -68,7 +68,7 @@ def rrs_export(args):
 
 def rrs_import(args):
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from django.db import transaction
     from rrs.models import RecipeUpstreamHistory, RecipeUpstream
     from layerindex.models import Recipe
@@ -121,7 +121,7 @@ def rrs_import(args):
 
 def rrs_remove_duplicates(args):
     utils.setup_django()
-    import settings
+    from django.conf import settings
     from django.db import transaction
     from rrs.models import RecipeUpstreamHistory
     from layerindex.models import Recipe
diff --git a/rrs/tools/rrs_distros.py b/rrs/tools/rrs_distros.py
index 4c5b273..e6717c1 100755
--- a/rrs/tools/rrs_distros.py
+++ b/rrs/tools/rrs_distros.py
@@ -24,7 +24,7 @@ from layerindex import utils
 utils.setup_django()
 from django.db import transaction
 from django.core.exceptions import ObjectDoesNotExist, MultipleObjectsReturned
-import settings
+from django.conf import settings
 
 logger = get_logger("RecipeDistros", settings)
 fetchdir = settings.LAYER_FETCH_DIR
diff --git a/rrs/tools/rrs_maintainer_history.py b/rrs/tools/rrs_maintainer_history.py
index a6da861..c509e5a 100755
--- a/rrs/tools/rrs_maintainer_history.py
+++ b/rrs/tools/rrs_maintainer_history.py
@@ -21,7 +21,7 @@ from layerindex import utils, recipeparse
 
 utils.setup_django()
 from django.db import transaction
-import settings
+from django.conf import settings
 
 from layerindex.models import Recipe, LayerBranch, LayerItem
 from rrs.models import MaintenancePlan, Maintainer, RecipeSymbol, RecipeMaintainerHistory, RecipeMaintainer, RecipeMaintenanceLink
diff --git a/rrs/tools/rrs_upgrade_history.py b/rrs/tools/rrs_upgrade_history.py
index b762144..6326914 100755
--- a/rrs/tools/rrs_upgrade_history.py
+++ b/rrs/tools/rrs_upgrade_history.py
@@ -27,7 +27,7 @@ from layerindex import utils
 import git
 
 utils.setup_django()
-import settings
+from django.conf import settings
 
 logger = get_logger("HistoryUpgrade", settings)
 fetchdir = settings.LAYER_FETCH_DIR
diff --git a/rrs/tools/rrs_upstream_email.py b/rrs/tools/rrs_upstream_email.py
index 9341333..0468c2d 100755
--- a/rrs/tools/rrs_upstream_email.py
+++ b/rrs/tools/rrs_upstream_email.py
@@ -27,7 +27,7 @@ from django.template.loader import get_template
 from django.template import Context, Template
 from django.urls import reverse
 from django.contrib.sites.models import Site
-import settings
+from django.conf import settings
 
 from layerindex.models import LayerItem, LayerBranch, Recipe
 from rrs.models import Maintainer, RecipeMaintainerHistory, RecipeMaintainer, \
diff --git a/rrs/tools/rrs_upstream_history.py b/rrs/tools/rrs_upstream_history.py
index 2a17c30..69c4354 100755
--- a/rrs/tools/rrs_upstream_history.py
+++ b/rrs/tools/rrs_upstream_history.py
@@ -24,7 +24,7 @@ from layerindex import utils
 utils.setup_django()
 from django.db import transaction
 from django.core.exceptions import ObjectDoesNotExist
-import settings
+from django.conf import settings
 
 logger = get_logger("UpstreamHistory", settings)
 fetchdir = settings.LAYER_FETCH_DIR
diff --git a/rrs/tools/upgrade_history_internal.py b/rrs/tools/upgrade_history_internal.py
index 7f3b93e..4032ded 100644
--- a/rrs/tools/upgrade_history_internal.py
+++ b/rrs/tools/upgrade_history_internal.py
@@ -577,7 +577,7 @@ if __name__=="__main__":
     try:
         utils.setup_django()
         from django.db import transaction
-        import settings
+        from django.conf import settings
 
         logger = get_logger("HistoryUpgrade", settings)
 
diff --git a/urls.py b/urls.py
index db94959..295fc0b 100644
--- a/urls.py
+++ b/urls.py
@@ -14,7 +14,7 @@ from layerindex.auth_views import CaptchaRegistrationView, CaptchaPasswordResetV
 from django.contrib import admin
 admin.autodiscover()
 
-import settings
+from django.conf import settings
 
 urlpatterns = [
     re_path(r'^layerindex/', include('layerindex.urls')),

