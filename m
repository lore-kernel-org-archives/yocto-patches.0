Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6516.1794636642971157932
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 22:10:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=pFQHumbt;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2281815a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636642; x=1795241442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jLLut6/3CmrQrImlPiEiDZetIUF/XmvDEy3cSVNL+k=;
        b=pFQHumbtBcPv7WppacqSPqXEeKr77TXf3jgcc8CYz4zrjPmPfh9x3wIDImbBDtBDaP
         0SWeAaj44DxXeOb4aBtEEWgq+QYSLONmyY2authzO7i27YLm5LMHFI1Nkg/6QpZ08StD
         XM8c7J7YB9NPhmwbkezPOU+OSxcdF8oxbShXYX07DHRTFPpJzGeeCSvSguYOw9jj0D2j
         KI9oQVO4aK9k8V1JWqse6HnShIh66OT8/MIkkMarbpQNoU+2TY1oQjnCcWwjWGUbHR9b
         dd4DiO3fs4oOoq7xTPBaLkqFAYfgZuBzkQ5Q6qLNjyg4U8yZbjdGEpN7tIMw1BOfa8xG
         0ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636642; x=1795241442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jLLut6/3CmrQrImlPiEiDZetIUF/XmvDEy3cSVNL+k=;
        b=CtxJrdfqlvg+KpPfIGmBZetEfy7VDku3ZFMjakOSEYv/WHvWMpwt3F5hoQPONoKlER
         Df1peqdprdNlOqKFCbvn3F0yo34o4fmIF0OVJggX4cPFifl+Dy0sHD1C9RUQQaQFGu5b
         l67o6Y8Jr7G1acbnra7AbttYZLBH5ARTp8Bx45MVcMmDodKrJuyOVKgCvASmaR1Ytff9
         blYGLFVHWhKDEWVCNbygGx51/qth95vPEMHuGvxTKdOZdwvFvg9FzR2wmAZOEfdWN2GQ
         22FtBDvITAj1W5+6fe1oIfwmRpCnt8a6/5qzYCzWt6FwKqyIwp5sO2l18/lCzE2d/xDd
         sLcA==
X-Gm-Message-State: APuU4Z/JEEOlz/2SmNHR0BFgWAqHmLwyX9vIPQvE+rl93PbE11y0mUFx
	mgXLoRmn3Gwj2xoqSWAtQMYP4D6I8OxMmGwzcE5jET3DQmIECD5SVvMGjt6ylg==
X-Gm-Gg: AYBFou1JJO3E4bP1ziHEcQtE4sRmL3TuUcl+vE3s88UgvGlMYELAXlSqeo6QkdX7Lhk
	j9yy8aSWjMjV9EJoxqqyiWHKMdEn8ZZr899Vd42KzXIaaG5X3UBlKAa07iVt6/5BgQSYok3GRno
	ltF1GiSDiGJGpnwYYznAv50P/KcAuvymYdABO4qs9T8ynmf3Y768W/fm3EwaWR/HjAkoZKjWhez
	CIGu0Il3Le54kNv1nYrj/1j7YpTOM32bIaVu3l7zk0sDiOSQweF19i9R4DwRYkLc+dH5+1exU8l
	RuDxjzIXXbbiBLR19/hvW48YtvS9xFu6ehB43QB9ZWzjsz/P5Gl06TD2ue3vbvc0GLrDMGJ9g6p
	+HR+4ZGs1USO2c4Lx9c2x9Ry3IeOmxYzSakPHhM6gido0kWB0vqp7SOuLDUCvm3k3m22AtF+EFM
	51FiObVFcJNlzKsAq56XB8aVxtNXdHBUIN4LJ2vW+osJj8tB29sFQltrYuU9LbZWfEiRLg+4cYn
	aE/SCGxCTXTZc6f32YA2fzymXMn9Nv188ImD7aOGS+NXGiQFcJzv0LWrsFIRy7Qxfyek5Z2h7us
	oDYoYyz0sBJoKGXwoxNOJsaBpkn3g6EGngJBBgYD/PtyNjwNRwCkRqtiVaxTuko=
X-Received: by 2002:a17:90b:5648:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3b1b0a3c18fmr4744882a91.46.1794636641857;
        Fri, 13 Nov 2026 22:10:41 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm7376186a91.10.2026.11.13.22.10.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 22:10:41 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex: email maintainers who opt in when their layer fails
Date: Fri, 13 Nov 2026 22:10:38 -0800
Message-ID: <20261114061038.18512-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 06:10:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5372
Content-Type: text/plain; charset="utf-8"

Maintainers only found out that their layer failed to parse by looking
at its update history. Add "Email me when my layers fail to parse" to
the profile page, off by default. At the end of each update, email the
users who opted in and are an active maintainer of a layer branch that
has errors in this update but had none in its previous one, with a link
to the update's log. If more than half of the layer branches of a large
update newly fail, the problem is probably the update itself, so email
the site admins once instead of the maintainers.

[YOCTO #11196]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This adds migration 0058, so it applies on top of "[PATCH 0/2] Let
maintainers change their email address safely" (bug 11195, migration
0057) and the 14348 series it builds on, and on master-next.

Applying the rule to the last two updates of a test instance loaded
with a copy of the layers.openembedded.org database: on 2026-11-13, 0
of 11 layer branches newly failed, so no emails; on 2026-11-14, 45 of
54 did, so one email to the admins and none to maintainers. That spike
came from "update: record errors in a layer's first parse against the
layer" recording dependency failures as layer updates for the first
time, which the admin rule is meant for.

 layerindex/forms.py                           |  3 +
 .../0058_userprofile_notify_parse_errors.py   | 16 ++++
 layerindex/models.py                          |  2 +
 layerindex/notify.py                          | 70 ++++++++++++++++
 layerindex/update.py                          |  3 +
 layerindex/views.py                           |  5 ++
 tests/test_parse_error_mail.py                | 82 +++++++++++++++++++
 tests/test_profile_email.py                   | 11 ++-
 8 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 layerindex/migrations/0058_userprofile_notify_parse_errors.py
 create mode 100644 layerindex/notify.py
 create mode 100644 tests/test_parse_error_mail.py

diff --git a/layerindex/forms.py b/layerindex/forms.py
index 7fcdbb0..bc9f212 100644
--- a/layerindex/forms.py
+++ b/layerindex/forms.py
@@ -211,6 +211,8 @@ class EditNoteForm(StyledModelForm):
 
 
 class EditProfileForm(StyledModelForm):
+    notify_parse_errors = forms.BooleanField(label='Email me when my layers fail to parse', required=False,
+                                             help_text='Sent when a layer branch you maintain starts to fail')
     current_password = forms.CharField(label='Current password', required=False, strip=False,
                                        widget=forms.PasswordInput(attrs={'autocomplete': 'current-password'}),
                                        help_text='Needed to change your email address')
@@ -233,6 +235,7 @@ class EditProfileForm(StyledModelForm):
                 'autocomplete': 'off'
             })
         user = kwargs.get("instance")
+        self.fields['notify_parse_errors'].initial = UserProfile.objects.filter(user=user, notify_parse_errors=True).exists()
         try:
             self.fields['security_question_1'].initial=user.userprofile.securityquestionanswer_set.all()[0].security_question
             self.fields['security_question_2'].initial=user.userprofile.securityquestionanswer_set.all()[1].security_question
diff --git a/layerindex/migrations/0058_userprofile_notify_parse_errors.py b/layerindex/migrations/0058_userprofile_notify_parse_errors.py
new file mode 100644
index 0000000..3739cb3
--- /dev/null
+++ b/layerindex/migrations/0058_userprofile_notify_parse_errors.py
@@ -0,0 +1,16 @@
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0057_userprofile_previous_email'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='userprofile',
+            name='notify_parse_errors',
+            field=models.BooleanField(default=False, help_text='Sent when a layer branch you maintain starts to fail', verbose_name='Email me when my layers fail to parse'),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index 883168c..4060adb 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -965,6 +965,8 @@ class UserProfile(models.Model):
     # The confirmed email address before a change of address that has not
     # been confirmed yet, to move the user's maintainer records once it is
     previous_email = models.CharField(max_length=255, blank=True)
+    notify_parse_errors = models.BooleanField('Email me when my layers fail to parse', default=False,
+                                              help_text='Sent when a layer branch you maintain starts to fail')
 
     def pending_maintainer_records(self):
         """Maintainer records still under the user's previous address"""
diff --git a/layerindex/notify.py b/layerindex/notify.py
new file mode 100644
index 0000000..37869bc
--- /dev/null
+++ b/layerindex/notify.py
@@ -0,0 +1,70 @@
+# Email notifications about layer updates
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+from django.conf import settings
+from django.contrib.sites.models import Site
+from django.core.mail import mail_admins, send_mail
+from django.urls import reverse
+
+from layerindex.models import LayerMaintainer, LayerUpdate, UserProfile
+
+# ponytail: fixed thresholds. If more than half of the layer branches in an
+# update of at least this many newly fail, something is probably wrong with
+# the update itself, not the layers.
+SYSTEMIC_MIN_LAYERBRANCHES = 10
+
+
+def newly_failed(update):
+    """Layer updates in this update with errors where the layer branch's
+    previous update had none"""
+    failed = []
+    for layerupdate in LayerUpdate.objects.filter(update=update, errors__gt=0).select_related('layer', 'branch'):
+        previous = LayerUpdate.objects.filter(layer=layerupdate.layer, branch=layerupdate.branch,
+                                              started__lt=layerupdate.started).order_by('-started').first()
+        if not (previous and previous.errors):
+            failed.append(layerupdate)
+    return failed
+
+
+def notify_parse_errors(update, logger):
+    """Email users who opted in when a layer branch they maintain starts to
+    fail, or the site admins instead if most layers did"""
+    failed = newly_failed(update)
+    if not failed:
+        return
+    site = Site.objects.get_current()
+
+    def url(layerupdate):
+        return 'https://%s%s' % (site.domain, reverse('layerupdate', args=(layerupdate.id,)))
+
+    total = LayerUpdate.objects.filter(update=update).count()
+    if total >= SYSTEMIC_MIN_LAYERBRANCHES and len(failed) * 2 > total:
+        logger.warning('%d of %d layer branches newly failed; telling the admins instead of the maintainers'
+                       % (len(failed), total))
+        mail_admins('Layer index update: %d of %d layer branches newly failed' % (len(failed), total),
+                    'This is probably a problem with the update rather than with the layers, so no\n'
+                    'maintainers were emailed. For example:\n\n%s\n'
+                    % '\n'.join('  %s (%s): %s' % (lu.layer.name, lu.branch.name, url(lu)) for lu in failed[:20]))
+        return
+
+    subscribers = UserProfile.objects.filter(notify_parse_errors=True, user__is_active=True).select_related('user')
+    by_email = {p.user.email.strip().lower(): p.user for p in subscribers if p.user.email}
+    for layerupdate in failed:
+        maintainers = LayerMaintainer.objects.filter(layerbranch__layer=layerupdate.layer,
+                                                     layerbranch__branch=layerupdate.branch, status='A')
+        to = sorted({by_email[m.email.strip().lower()].email for m in maintainers
+                     if m.email.strip().lower() in by_email})
+        if not to:
+            continue
+        try:
+            send_mail('%s (%s) failed to parse on %s' % (layerupdate.layer.name, layerupdate.branch.name, site.name),
+                      'The layer index update of %s on the %s branch found %d errors:\n\n  %s\n\n'
+                      'You get this email because you maintain this layer and asked to be told when it\n'
+                      'starts to fail; you can turn it off on your profile page.\n'
+                      % (layerupdate.layer.name, layerupdate.branch.name, layerupdate.errors, url(layerupdate)),
+                      settings.DEFAULT_FROM_EMAIL, to)
+        except Exception as e:
+            logger.warning('Failed to email %s about %s: %s' % (', '.join(to), layerupdate.layer.name, e))
diff --git a/layerindex/update.py b/layerindex/update.py
index ca68e3e..436ddb6 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -621,6 +621,9 @@ def main():
         update_purge_days = getattr(settings, 'UPDATE_PURGE_DAYS', 30)
         Update.objects.filter(started__lte=datetime.now()-timedelta(days=update_purge_days)).delete()
 
+        from layerindex.notify import notify_parse_errors
+        notify_parse_errors(update, logger)
+
     sys.exit(0)
 
 
diff --git a/layerindex/views.py b/layerindex/views.py
index 32f1c16..6e160c0 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1056,6 +1056,11 @@ class EditProfileFormView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
     def form_valid(self, form):
         self.object = form.save()
 
+        if 'notify_parse_errors' in form.changed_data:
+            profile, _ = UserProfile.objects.get_or_create(user=self.user)
+            profile.notify_parse_errors = form.cleaned_data['notify_parse_errors']
+            profile.save(update_fields=['notify_parse_errors'])
+
         if'answer_1' in form.changed_data:
             # If one security answer has changed, they all have. Delete current questions and add new ones.
             # Don't throw an error if we are editing the super user and they don't have security questions yet.
diff --git a/tests/test_parse_error_mail.py b/tests/test_parse_error_mail.py
new file mode 100644
index 0000000..6b478fc
--- /dev/null
+++ b/tests/test_parse_error_mail.py
@@ -0,0 +1,82 @@
+# layerindex-web - tests for the parse error emails to maintainers
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import logging
+from datetime import datetime, timedelta
+
+import pytest
+from django.contrib.auth.models import User
+from django.core import mail
+
+from layerindex.models import (Branch, LayerBranch, LayerItem, LayerMaintainer, LayerUpdate, Update,
+                               UserProfile)
+from layerindex.notify import notify_parse_errors
+
+LOG = logging.getLogger('test')
+START = datetime(2026, 11, 1)
+
+
+def make_layers(names):
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    layers = {}
+    for name in names:
+        layer = LayerItem.objects.create(name=name, status='P', layer_type='A', summary=name,
+                                         description=name, vcs_url='git://example.com/%s.git' % name)
+        LayerBranch.objects.create(layer=layer, branch=master)
+        layers[name] = layer
+    return layers
+
+
+def run_update(layers, failing, day):
+    update = Update.objects.create(started=START + timedelta(days=day), finished=START + timedelta(days=day))
+    for name, layer in layers.items():
+        lu = LayerUpdate(update=update, layer=layer, branch=Branch.objects.get(name='master'),
+                         started=START + timedelta(days=day), log='ERROR: broken\n' if name in failing else '')
+        lu.save()
+    return update
+
+
+def subscribe(username, email, notify=True, active=True):
+    user = User.objects.create_user(username, email, 'pw', is_active=active)
+    UserProfile.objects.create(user=user, notify_parse_errors=notify)
+
+
+@pytest.mark.django_db
+def test_maintainers_who_opted_in_get_mail_when_a_layer_starts_failing():
+    # [YOCTO #11196]
+    layers = make_layers(['meta-a', 'meta-b'])
+    lb = layers['meta-a'].layerbranch_set.get()
+    for name, email, status in (('Yes', 'Yes@example.com', 'A'), ('No', 'no@example.com', 'A'),
+                                ('Gone', 'gone@example.com', 'I')):
+        LayerMaintainer.objects.create(layerbranch=lb, name=name, email=email, status=status)
+    subscribe('yes', 'yes@example.com')
+    subscribe('no', 'no@example.com', notify=False)
+    subscribe('gone', 'gone@example.com')
+
+    run_update(layers, [], day=0)
+    notify_parse_errors(run_update(layers, ['meta-a'], day=1), LOG)
+    assert [m.to for m in mail.outbox] == [['yes@example.com']]
+    assert 'meta-a (master) failed to parse' in mail.outbox[0].subject
+    assert '/layerindex/layerupdate/' in mail.outbox[0].body
+
+    # Still failing: no new mail
+    mail.outbox.clear()
+    notify_parse_errors(run_update(layers, ['meta-a'], day=2), LOG)
+    assert mail.outbox == []
+
+
+@pytest.mark.django_db
+def test_mass_failure_goes_to_the_admins(settings):
+    settings.ADMINS = [('Admin', 'admin@example.com')]
+    layers = make_layers(['meta-%d' % i for i in range(10)])
+    for layer in layers.values():
+        LayerMaintainer.objects.create(layerbranch=layer.layerbranch_set.get(), name='M', email='m@example.com')
+    subscribe('m', 'm@example.com')
+
+    run_update(layers, [], day=0)
+    notify_parse_errors(run_update(layers, list(layers)[:6], day=1), LOG)
+    assert [m.to for m in mail.outbox] == [['admin@example.com']]
+    assert '6 of 10 layer branches newly failed' in mail.outbox[0].subject
diff --git a/tests/test_profile_email.py b/tests/test_profile_email.py
index 85dcaa0..a35db68 100644
--- a/tests/test_profile_email.py
+++ b/tests/test_profile_email.py
@@ -34,9 +34,9 @@ class TestProfileEmailChange(TestCase):
             SecurityQuestionAnswer.objects.create(user=profile, security_question=question, answer='x')
         self.client.force_login(self.user)
 
-    def _post_profile(self, email, password='pw'):
+    def _post_profile(self, email, password='pw', **extra):
         hashkey = CaptchaStore.generate_key()
-        data = {
+        data = {**extra,
             'current_password': password,
             'username': 'someone',
             'first_name': '',
@@ -147,3 +147,10 @@ class TestProfileEmailChange(TestCase):
         self.assertTrue(layer.user_can_edit(self.user))
         self.assertEqual([m.to for m in mail.outbox], [['new@example.com']])
         self.assertEqual(UserProfile.objects.get(user=self.user).previous_email, '')
+
+    def test_opt_in_to_parse_error_mail(self):
+        # [YOCTO #11196]
+        self._post_profile('old@example.com', notify_parse_errors='on')
+        self.assertTrue(UserProfile.objects.get(user=self.user).notify_parse_errors)
+        self._post_profile('old@example.com')
+        self.assertFalse(UserProfile.objects.get(user=self.user).notify_parse_errors)

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: 6c677e4190187d389840d2a94b4d857a69c0d647
prerequisite-patch-id: 282bc018dfe6528deb8363d3cbd1b31671c4b606
prerequisite-patch-id: 41ede4992addb0d7f364a079e773a77943b6341f
prerequisite-patch-id: 51420179b7abf0bd91736545eb4a692058cca8b4
-- 
2.56.0

