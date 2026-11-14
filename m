Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6322.1794635550585858989
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 21:52:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=02HpjQSB;
 spf=pass (domain: gmail.com, ip: 209.85.210.177, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso2018404b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 21:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794635550; x=1795240350; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2sm1RCJZ2ftXxwWB6WQpVwsls3UyGi9HXpXby0zP7U=;
        b=02HpjQSBK8ed2AbDvNkJBPzZijfAJFBrjT7FE5LWIaszgqhunbsWUpA4L4JuX0FlaX
         WP5lcr4XI2pGaljGLL2ynPX+33oL8CqT0wkwZjZNFC5DNJ3FuJTPEb6ZpdMadS7yBEhS
         ghHbuiCqHwKw1dFdFXVKab9ypJGHQzs4Qu1iZMMFDCzUYkcX30g971NdPHkInrkMhA/v
         /OFLs3dmR06/nIq49xlQHvjKkk2eNcuOAy45J4S/U/suuczNZj/D7oqIvPLrZe3fscwP
         dzUZtIcW9PUc+YsDkf4t7g1ijOhjoCFndPWwbudu2ofZoueJcP8GrQeWAjcEcPYZhc50
         cf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794635550; x=1795240350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2sm1RCJZ2ftXxwWB6WQpVwsls3UyGi9HXpXby0zP7U=;
        b=nqivw4W+jjfkV1+w4Uv0UTMQQKDtbGYaC5U6IQIv2ilKUyMri788HCMGPhQFWheG6e
         OlNCbBeR88Eno97y5SkspLbNPIN1bZ8t3ZjhYE6zie/l6CtJt5WUFJ4tiQt8iMcG+aly
         +oBa6VUhsDm+BkVluVzdJ3jO71lXP8f6NsS8k+OhBZTO3oqqwND9kNPreIuAVjDgk8vW
         2ALLsNMrrJBAjRbxbI1dREVi881zvAdwgON7563C6DQPviLjRqLK6GGyvs6NvEkEdaCE
         q2ppunKwMG3qd5kAmQgoMkNm9xmjp6DBmK5sMdBBtj1qmWccKsSjJ8+n3coAVVsIY+dk
         6/BQ==
X-Gm-Message-State: APuU4Z+Y0q9EpE00TCwhzP4mEw8WPsb8C4RrSSq7j35UA2BC6xWFKtdE
	+PgFcxZuxkvZOI7ftJ44F4wZnVUDsf8CCK3vY8LSOU/tRMOSAcz54fd1If+GYWUV
X-Gm-Gg: AYBFou2cWIa/lNKu6q/u0rAOcJedql9ei+aKLY0/H11GQlHrmlurukqntG7xj4M/5yk
	G4m0KrkDWXpLNhRhHiyFSa00ERDuLXZnt9KyHHy8dQU5UpQ6o+z2jDI09/85DimKXZQxGRgZ948
	SSSx39lkZXLOFENHqIJAEbmb0kJQAvko0q2KSAoZDE/99xyGEdE8dA5G4AMQHI411olTX/JyQws
	C9pdr6mWWDjiJ0y5wXGD3hiZU1Hmp4ljEEWlZa3zdDuBd/J41/DZIU25RoTnisxxhfkDHWo1I3f
	GDVfxhHmtpBHr1NoxPS2TS/z7cJM9SNSHdd5ftbijHEP+5JHF1ssAFFxJxOMsJ/NnICN/vllCHt
	MDv9kdsMX9wXvh4UNPFnQ4X+f05nKn9E6cMGsV5nS0X9sgQQ1ApEFUBuUaXTQLqdngEAV7rydyZ
	+zCYBGFKH3ezteALvEi8XOjEs0UYcpIj4jGQ3AwgbUM1+LWVCVzGWDnhC123j9pSFvGmk+w9+Fk
	O70mjEsBiWD70UVis4mYo+b23oFPL23RN+ssvkFiHE7VqlgPnKxCENoAUmE9P7abbN5GmhgynC/
	2Qv1AISfiOvbg2N7cmvONUFzweBBOj9XUHHhFQYFPg0YIJaTZOBAy07nlkqrmw==
X-Received: by 2002:a05:6a00:2350:b0:897:ffff:c18a with SMTP id d2e1a72fcca58-8beb3b3cea5mr4807965b3a.7.1794635549823;
        Fri, 13 Nov 2026 21:52:29 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2635285sm1957746b3a.44.2026.11.13.21.52.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 21:52:28 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] layerindex: let a maintainer keep their layers when they change email
Date: Fri, 13 Nov 2026 21:52:16 -0800
Message-ID: <20261114055216.2636-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114055216.2636-1-tim.orling@konsulko.com>
References: <20261114055216.2636-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 05:52:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5371
Content-Type: text/plain; charset="utf-8"

Edit rights on a layer come from matching the user's email address
against the layer's maintainer records, so a maintainer who changed the
address on their profile lost access to their layers, and an admin had
to change the maintainer records of every layer branch by hand.

Remember the confirmed address when the email is changed. Once the new
address is confirmed through the activation link, ask the site admins
to approve moving the maintainer records to it, and move them when an
admin runs "Approve moving maintainer records" on the user's profile;
the user is emailed then.

Since that moves edit rights, make changing the email address need the
current password, so that a logged-in session alone is not enough, and
tell the old address about the change.

[YOCTO #11195]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/admin.py                           | 26 +++++-
 layerindex/forms.py                           |  8 ++
 .../0057_userprofile_previous_email.py        | 16 ++++
 layerindex/models.py                          | 20 +++++
 layerindex/views.py                           | 42 +++++++++
 tests/test_profile_email.py                   | 85 +++++++++++++++++--
 6 files changed, 189 insertions(+), 8 deletions(-)
 create mode 100644 layerindex/migrations/0057_userprofile_previous_email.py

diff --git a/layerindex/admin.py b/layerindex/admin.py
index f8b2f6e..226f43f 100644
--- a/layerindex/admin.py
+++ b/layerindex/admin.py
@@ -7,7 +7,8 @@
 # SPDX-License-Identifier: MIT
 
 from layerindex.models import *
-from django.contrib import admin
+from django.conf import settings
+from django.contrib import admin, messages
 from reversion_compare.admin import CompareVersionAdmin
 from django.forms import TextInput
 from django.contrib.sites.models import Site
@@ -238,4 +239,25 @@ admin.site.register(PythonEnvironment)
 admin.site.register(SiteNotice)
 admin.site.register(SecurityQuestion)
 admin.site.register(SecurityQuestionAnswer)
-admin.site.register(UserProfile)
+class UserProfileAdmin(admin.ModelAdmin):
+    list_display = ('user', 'previous_email')
+    search_fields = ('user__username', 'user__email', 'previous_email')
+    actions = ['approve_maintainer_email_change']
+
+    @admin.action(description='Approve moving maintainer records to the new email address')
+    def approve_maintainer_email_change(self, request, queryset):
+        from django.core.mail import send_mail
+        for profile in queryset.exclude(previous_email=''):
+            user = profile.user
+            if not user.is_active:
+                # The new address hasn't been confirmed yet
+                self.message_user(request, '%s has not confirmed their new address yet; nothing moved' % user.username, messages.WARNING)
+                continue
+            moved = profile.move_maintainer_records()
+            if moved:
+                send_mail('Maintainer email address updated on %s' % Site.objects.get_current().name,
+                          'Your maintainer records were moved to %s for:\n\n  %s\n' % (user.email, '\n  '.join(moved)),
+                          settings.DEFAULT_FROM_EMAIL, [user.email])
+            self.message_user(request, 'Moved %d maintainer records of %s to %s' % (len(moved), user.username, user.email))
+
+admin.site.register(UserProfile, UserProfileAdmin)
diff --git a/layerindex/forms.py b/layerindex/forms.py
index 733adc2..7fcdbb0 100644
--- a/layerindex/forms.py
+++ b/layerindex/forms.py
@@ -211,6 +211,9 @@ class EditNoteForm(StyledModelForm):
 
 
 class EditProfileForm(StyledModelForm):
+    current_password = forms.CharField(label='Current password', required=False, strip=False,
+                                       widget=forms.PasswordInput(attrs={'autocomplete': 'current-password'}),
+                                       help_text='Needed to change your email address')
     captcha = CaptchaField(label='Verification', help_text='Please enter the letters displayed for verification purposes', error_messages={'invalid':'Incorrect entry, please try again'})
     security_question_1 = forms.ModelChoiceField(queryset=SecurityQuestion.objects.all())
     answer_1 = forms.CharField(widget=forms.TextInput(), label='Answer', initial="*****")
@@ -265,6 +268,11 @@ class EditProfileForm(StyledModelForm):
 
     def clean(self):
         cleaned_data = super(EditProfileForm, self).clean()
+        # A logged-in session alone must not be enough to change the address
+        # that layer edit rights and password resets are tied to
+        if 'email' in self.changed_data:
+            if not self.instance.check_password(cleaned_data.get('current_password') or ''):
+                self.add_error('current_password', 'Enter your current password to change your email address')
         for data in self.changed_data:
             # Check if a security answer has been updated. If one is updated, they must all be
             # and each security question must be unique.
diff --git a/layerindex/migrations/0057_userprofile_previous_email.py b/layerindex/migrations/0057_userprofile_previous_email.py
new file mode 100644
index 0000000..495fee8
--- /dev/null
+++ b/layerindex/migrations/0057_userprofile_previous_email.py
@@ -0,0 +1,16 @@
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0056_layerdependency_from_layer_conf'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='userprofile',
+            name='previous_email',
+            field=models.CharField(blank=True, max_length=255),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index fd8e88f..883168c 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -962,6 +962,26 @@ class SecurityQuestion(models.Model):
 class UserProfile(models.Model):
     user = models.OneToOneField(User, on_delete=models.CASCADE)
     answer_attempts = models.IntegerField(default=0)
+    # The confirmed email address before a change of address that has not
+    # been confirmed yet, to move the user's maintainer records once it is
+    previous_email = models.CharField(max_length=255, blank=True)
+
+    def pending_maintainer_records(self):
+        """Maintainer records still under the user's previous address"""
+        if not self.previous_email or self.previous_email.strip().lower() == self.user.email.strip().lower():
+            return LayerMaintainer.objects.none()
+        return LayerMaintainer.objects.filter(email__iexact=self.previous_email.strip())
+
+    def move_maintainer_records(self):
+        """Move the maintainer records to the user's current address. Returns
+        the layer branches they are for, as "layer (branch)"."""
+        maintainers = self.pending_maintainer_records()
+        moved = sorted('%s (%s)' % (m.layerbranch.layer.name, m.layerbranch.branch.name)
+                       for m in maintainers.select_related('layerbranch__layer', 'layerbranch__branch'))
+        maintainers.update(email=self.user.email)
+        self.previous_email = ''
+        self.save(update_fields=['previous_email'])
+        return moved
 
     def __str__(self):
         return '%s' % (self.user)
diff --git a/layerindex/views.py b/layerindex/views.py
index 35186e6..32f1c16 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -24,6 +24,7 @@ from django.contrib.auth.hashers import make_password
 from django.contrib.auth.models import Permission, User
 from django.contrib.messages.views import SuccessMessageMixin
 from django.contrib.sites.models import Site
+from django.core.mail import mail_admins, send_mail
 from django.core.exceptions import PermissionDenied
 from django.urls import resolve, reverse, reverse_lazy
 from django.db import transaction
@@ -43,6 +44,7 @@ from django.views.generic.base import RedirectView
 from django.views.generic.edit import (CreateView, DeleteView, FormView,
                                        UpdateView)
 from django_registration.backends.activation.views import RegistrationView
+from django_registration.signals import user_activated
 from reversion.models import Revision
 
 from django.conf import settings
@@ -1002,6 +1004,30 @@ class HistoryListView(ListView):
         return Revision.objects.all().order_by('-date_created')
 
 
+@receiver(user_activated)
+def request_maintainer_email_change(sender, user, request, **kwargs):
+    """Once a changed email address is confirmed, ask the site admins to
+    approve moving the user's maintainer records to it, since that gives the
+    new address edit rights on the layers."""
+    profile = UserProfile.objects.filter(user=user).exclude(previous_email='').first()
+    if not profile:
+        return
+    layers = sorted(set('%s (%s)' % (m.layerbranch.layer.name, m.layerbranch.branch.name)
+                        for m in profile.pending_maintainer_records().select_related('layerbranch__layer', 'layerbranch__branch')))
+    if not layers:
+        profile.previous_email = ''
+        profile.save(update_fields=['previous_email'])
+        return
+    mail_admins('Approve maintainer email change for %s' % user.username,
+                'User "%s" changed their email address from %s to %s and confirmed it.\n'
+                'Their maintainer records for these layers will move to the new address once you\n'
+                'approve it ("Approve moving maintainer records" on their user profile):\n\n  %s\n\n%s\n'
+                % (user.username, profile.previous_email, user.email, '\n  '.join(layers),
+                   request.build_absolute_uri(reverse('admin:layerindex_userprofile_change', args=(profile.pk,)))))
+    messages.info(request, 'Your new email address is confirmed. Your maintainer records for %s will move to it '
+                  'once a site administrator approves the change; you will be emailed then.' % ', '.join(layers))
+
+
 class EditProfileFormView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
     form_class = EditProfileForm
 
@@ -1055,6 +1081,22 @@ class EditProfileFormView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
                                                   answer=make_password(answer_3))
 
         if 'email' in form.changed_data:
+            # Remember the confirmed address, so that once the new one is
+            # confirmed the user's maintainer records can move to it. Keep the
+            # first one if the address is changed again before that.
+            old_email = form.initial.get('email', '')
+            profile, _ = UserProfile.objects.get_or_create(user=self.user)
+            if not profile.previous_email:
+                profile.previous_email = old_email
+                profile.save(update_fields=['previous_email'])
+            # Tell the old address, in case it wasn't the owner who did this
+            if old_email:
+                site = Site.objects.get_current()
+                send_mail('Email address changed on %s' % site.name,
+                          'The email address of your account "%s" on %s was changed to %s.\n\n'
+                          'If you did not do this, please contact the site administrators.\n'
+                          % (self.user.username, site.name, form.cleaned_data['email']),
+                          settings.DEFAULT_FROM_EMAIL, [old_email])
             # Take a copy of request.user as it is about to be invalidated by logout()
             user = self.request.user
             logout(self.request)
diff --git a/tests/test_profile_email.py b/tests/test_profile_email.py
index 57feee5..85dcaa0 100644
--- a/tests/test_profile_email.py
+++ b/tests/test_profile_email.py
@@ -4,15 +4,20 @@
 #
 # SPDX-License-Identifier: MIT
 
+import re
+from urllib.parse import unquote
+
 import pytest
 from captcha.models import CaptchaStore
 from django.contrib.auth import authenticate
 from django.contrib.auth.models import User
+from django.contrib.messages import get_messages
 from django.core import mail
-from django.test import RequestFactory, TestCase
+from django.test import Client, RequestFactory, TestCase
 from django.urls import reverse
 
-from layerindex.models import SecurityQuestion, SecurityQuestionAnswer, UserProfile
+from layerindex.models import (Branch, LayerBranch, LayerItem, LayerMaintainer, SecurityQuestion,
+                               SecurityQuestionAnswer, UserProfile)
 
 
 @pytest.mark.django_db
@@ -29,9 +34,10 @@ class TestProfileEmailChange(TestCase):
             SecurityQuestionAnswer.objects.create(user=profile, security_question=question, answer='x')
         self.client.force_login(self.user)
 
-    def _post_profile(self, email):
+    def _post_profile(self, email, password='pw'):
         hashkey = CaptchaStore.generate_key()
         data = {
+            'current_password': password,
             'username': 'someone',
             'first_name': '',
             'last_name': '',
@@ -55,9 +61,22 @@ class TestProfileEmailChange(TestCase):
         # Logged out, and an inactive account cannot log back in
         self.assertNotIn('_auth_user_id', self.client.session)
         self.assertIsNone(authenticate(RequestFactory().post('/'), username='someone', password='pw'))
-        # The activation link only goes to the new address
-        self.assertEqual(len(mail.outbox), 1)
-        self.assertEqual(mail.outbox[0].to, ['maintainer@example.com'])
+        # The activation link only goes to the new address, and the old
+        # address is told about the change
+        self.assertEqual(sorted(m.to[0] for m in mail.outbox), ['maintainer@example.com', 'old@example.com'])
+        notice = [m for m in mail.outbox if m.to == ['old@example.com']][0]
+        self.assertIn('was changed to maintainer@example.com', notice.body)
+        self.assertNotIn('activation_key', notice.body)
+
+    def test_email_change_needs_current_password(self):
+        for password in ('', 'wrong'):
+            response = self._post_profile('maintainer@example.com', password=password)
+            self.assertEqual(response.status_code, 200)
+            self.assertIn('current_password', response.context['form'].errors)
+        self.user.refresh_from_db()
+        self.assertEqual(self.user.email, 'old@example.com')
+        self.assertTrue(self.user.is_active)
+        self.assertEqual(len(mail.outbox), 0)
 
     def test_unchanged_email_keeps_account_active(self):
         response = self._post_profile('old@example.com')
@@ -74,3 +93,57 @@ class TestProfileEmailChange(TestCase):
             self.assertIn(reverse('login'), response['Location'])
         self.user.refresh_from_db()
         self.assertEqual(self.user.email, 'old@example.com')
+
+    def test_maintainer_records_move_only_after_admin_approval(self):
+        # [YOCTO #11195] a maintainer who changes their address keeps access
+        # to their layers, but only once the new address is confirmed and a
+        # site admin has approved it
+        master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+        kirkstone = Branch.objects.create(name='kirkstone', bitbake_branch='2.0')
+        layer = LayerItem.objects.create(name='meta-mine', status='P', layer_type='A', summary='x',
+                                         description='x', vcs_url='git://example.com/meta-mine.git')
+        mine = [LayerMaintainer.objects.create(layerbranch=LayerBranch.objects.create(layer=layer, branch=b),
+                                               name='Someone', email=email)
+                for b, email in ((master, 'old@example.com'), (kirkstone, 'Old@Example.com'))]
+        other = LayerMaintainer.objects.create(layerbranch=mine[0].layerbranch, name='Other',
+                                               email='other@example.com')
+        admin = User.objects.create_superuser('admin', 'admin@example.com', 'pw')
+        profile_pk = UserProfile.objects.get(user=self.user).pk
+
+        def emails():
+            return sorted(LayerMaintainer.objects.filter(pk__in=[m.pk for m in mine]).values_list('email', flat=True))
+
+        def approve():
+            client = Client()
+            client.force_login(admin)
+            return client.post(reverse('admin:layerindex_userprofile_changelist'),
+                               {'action': 'approve_maintainer_email_change', '_selected_action': [profile_pk]},
+                               follow=True)
+
+        self._post_profile('new@example.com')
+        # Approving before the new address is confirmed does nothing
+        approve()
+        self.assertEqual(emails(), ['Old@Example.com', 'old@example.com'])
+
+        activation = [m for m in mail.outbox if m.to == ['new@example.com']][0]
+        key = unquote(re.search(r'activation_key=(\S+)', activation.body).group(1))
+        mail.outbox.clear()
+        with self.settings(ADMINS=[('Admin', 'admin@example.com')]):
+            response = self.client.post(reverse('django_registration_activate'), {'activation_key': key})
+        self.user.refresh_from_db()
+        self.assertTrue(self.user.is_active)
+        # Confirming the address alone moves nothing, but asks the admins
+        self.assertEqual(emails(), ['Old@Example.com', 'old@example.com'])
+        self.assertFalse(layer.user_can_edit(self.user))
+        self.assertEqual([m.to for m in mail.outbox], [['admin@example.com']])
+        self.assertIn('meta-mine (kirkstone)', mail.outbox[0].body)
+        self.assertIn('once a site administrator approves', [str(m) for m in get_messages(response.wsgi_request)][0])
+
+        mail.outbox.clear()
+        approve()
+        self.assertEqual(emails(), ['new@example.com', 'new@example.com'])
+        other.refresh_from_db()
+        self.assertEqual(other.email, 'other@example.com')
+        self.assertTrue(layer.user_can_edit(self.user))
+        self.assertEqual([m.to for m in mail.outbox], [['new@example.com']])
+        self.assertEqual(UserProfile.objects.get(user=self.user).previous_email, '')
-- 
2.56.0

