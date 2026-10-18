Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE05CCF2C9
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:32:53 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21992.1792359164401122405
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:32:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kZ11+04A;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a706146559so1197155a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359164; x=1792963964; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IH2+rhTGmKAg6GEW9EpMEqPvInuLHU7FWrcdPxTPTy8=;
        b=kZ11+04A/I2N3j8m9YIGlBf3cNaBcE0AJn712aofDGWCGBK2vcFeUtVaY2+oVOhg5b
         66hxi7wxHgeMR8pkIbVj8/7aDa0yNZk0TgkdRfQO+X6fF0CnVWyOYteBbr3QWkzi40F9
         3agHRUeY6gBiJnB/15qm6TIxHq4U9bGyXIO84Rh8nCjGKZSracwHj+v/MKzTjcuuPNmQ
         oa4kDEmT4nx/+PW/lAUmTO0FGbIxfVYK94vY2yu5em+u/S5uZ0+BtGXNhQPcO3PemwF+
         wDCVn9GeWiPH9jVFtjMerD+jkgxF70v3Vc8sQH8xNHwlZNHVnss/LPeOszZWWyfgxTBB
         MpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359164; x=1792963964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IH2+rhTGmKAg6GEW9EpMEqPvInuLHU7FWrcdPxTPTy8=;
        b=10XGEyY0ExRvh8J/hRxPToISLdF2GUwElD0A+cLsbyr9DO0KYC6npBd0Hyw0+CfpbD
         6SRTeJGP3+s0ihb6QeIBZ32yCk8UmU3PBsufaJNb23qJqRGIMFRIHzsIx3urpHlaXRyN
         DPW7oSzvxqUteZ/c0MOYXAESBch45vRvD07d1uUlFl4pqeV6JIxZD+lV1PKZD5BiHX5F
         /r+GT6Bag1ApmZHtnN6WKe6wWDvO4jRHrlTN0t1rGnoWUeyPYrlia0PTDVTSImVbgTzU
         LHO0cZwZkoORrwlKS9IhTHjDmBJzlDe6G3P8Et2rxdxKiRepm5h/XOeCakKPQV8ZTy8E
         QjOg==
X-Gm-Message-State: AFq9FYL3S8bcO7Wb8C3tMpFcpuZw2BqaYntn7t9XWtVLtQg/HmcxlAAm
	lAfrs++f/uZYyxuRez5NyQ04MbMPsotYUOFdHUO6AjSfnzf5MsAESObjQw6fZhaE
X-Gm-Gg: AYBFou24Sqd1iXZh0ptPh9zBQYX/JPsTmXiFPxTkEIWcR51LSSQZDHJKTMfu4k8sE1d
	fvVtxPjOVdNAP4VK4xNlGEIkW6hmRbaRj658bOupyPEM6EzUmth6Pm/Zc/De2aSVuBxsdm0zyKt
	AM5nIKto74ucLhLJOxpPPwTiZ96mBf8jTwK9k9nr7A1MpCn1mHOJnt150qOBbCs9Q6OJMUkUtIl
	1hDiO3QSKm/i++AUEQ11XIMurpRUE3tkfTqVHZ2fNTcQ3CDZHoAXFLJrns8BAAGTe92aQX8geon
	xenMkgolWaPgJaAeffaLJGjDL868I11zHWepuPGv/OL1Giq2dAx1ufJRWJffaU8ieaipZNlDe8K
	0PACZRh+CpOU4iJ8gpSl6KVtWd2QfZxO/6ihSJYHq4FEcy6L4I/jZyXfrtqygqaR2bqufVHfNZH
	Zu6wnnS7bH457Kej8XHP9r58YRW1IgtmUFJhGlTokQgJGmuIm+HA1jGylN6N/P6/8smjVgT4/qm
	GKcWJxuYnjdbnZDrWAzjewPGlO5mRQ=
X-Received: by 2002:a17:90b:3148:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3acef60f597mr5215340a91.61.1792359163691;
        Sun, 18 Oct 2026 14:32:43 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7320sm17513914a91.6.2026.10.18.14.32.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:32:41 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] templates: fix account activation for django-registration 5
Date: Sun, 18 Oct 2026 14:32:33 -0700
Message-ID: <20261018213233.65737-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:32:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5071

Since the Django 5.2 upgrade (23fdeac) pulled in django-registration
5.x, sending an activation email fails with NoReverseMatch: the
template passed the activation key as a URL argument, but the
"django_registration_activate" URL now takes it as the activation_key
query parameter. New registrations, and users changing their email
address on the profile page, were left deactivated with no email sent.

The activation view is now a form that POSTs the key back and renders
django_registration/activation_form.html, so replace the old
activate.html and activation_failed.html templates with it.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 templates/django_registration/activate.html   | 18 -------
 .../activation_email_body.txt                 |  2 +-
 .../activation_failed.html                    | 13 -----
 .../django_registration/activation_form.html  | 21 ++++++++
 tests/test_account_activation.py              | 52 +++++++++++++++++++
 5 files changed, 74 insertions(+), 32 deletions(-)
 delete mode 100644 templates/django_registration/activate.html
 delete mode 100644 templates/django_registration/activation_failed.html
 create mode 100644 templates/django_registration/activation_form.html
 create mode 100644 tests/test_account_activation.py

diff --git a/templates/django_registration/activate.html b/templates/django_registration/activate.html
deleted file mode 100644
index 39c2bac..0000000
--- a/templates/django_registration/activate.html
+++ /dev/null
@@ -1,18 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-
-{% if account %}
-
-<p>{% trans "Account successfully activated" %}</p>
-
-<p><a href="{% url "login" %}">{% trans "Log in" %}</a></p>
-
-{% else %}
-
-<p>{% trans "Account activation failed" %}</p>
-
-{% endif %}
-
-{% endblock %}
diff --git a/templates/django_registration/activation_email_body.txt b/templates/django_registration/activation_email_body.txt
index 15dd99b..7061136 100644
--- a/templates/django_registration/activation_email_body.txt
+++ b/templates/django_registration/activation_email_body.txt
@@ -7,7 +7,7 @@ link is valid for {{ expiration_days }} days.
 
 {% endblocktrans %}
 
-http://{{ site.domain }}{% url "django_registration_activate" activation_key %}
+http://{{ site.domain }}{% url "django_registration_activate" %}?activation_key={{ activation_key|urlencode }}
 
 {% blocktrans %}
 If you did not make this request, please ignore this message.
diff --git a/templates/django_registration/activation_failed.html b/templates/django_registration/activation_failed.html
deleted file mode 100644
index 07b0cde..0000000
--- a/templates/django_registration/activation_failed.html
+++ /dev/null
@@ -1,13 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-
-{% blocktrans %}
-
-Activation has failed.
-<br/>
-
-{% endblocktrans %}
-
-{% endblock %}
diff --git a/templates/django_registration/activation_form.html b/templates/django_registration/activation_form.html
new file mode 100644
index 0000000..ea4e38f
--- /dev/null
+++ b/templates/django_registration/activation_form.html
@@ -0,0 +1,21 @@
+{% extends "base.html" %}
+{% load i18n %}
+
+{% block content %}
+
+{% if activation_error %}
+<div class="alert alert-danger">{{ activation_error.message }}</div>
+{% elif form.errors %}
+<div class="alert alert-danger">{% trans "This activation link is invalid or has expired." %}</div>
+{% else %}
+<p>{% trans "Click the button below to activate your account." %}</p>
+<form id="activation_form" method="post" action="">
+    {% for field in form %}
+        <input type="hidden" name="{{ field.html_name }}" value="{{ field.value|default_if_none:'' }}" />
+    {% endfor %}
+    <input type="submit" class="btn btn-default" value="{% trans 'Activate account' %}" />
+    {% csrf_token %}
+</form>
+{% endif %}
+
+{% endblock %}
diff --git a/tests/test_account_activation.py b/tests/test_account_activation.py
new file mode 100644
index 0000000..3fb56f7
--- /dev/null
+++ b/tests/test_account_activation.py
@@ -0,0 +1,52 @@
+# layerindex-web - tests for the account activation email and page
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import re
+
+import pytest
+from django.contrib.auth.models import User
+from django.core import mail
+from django.test import RequestFactory, TestCase
+from django.urls import reverse
+from django_registration.backends.activation.views import RegistrationView
+
+
+@pytest.mark.django_db
+class TestAccountActivation(TestCase):
+
+    def setUp(self):
+        self.user = User.objects.create_user('newuser', 'new@example.com', 'pw', is_active=False)
+
+    def _activation_path(self):
+        view = RegistrationView()
+        view.request = RequestFactory().get('/')
+        view.send_activation_email(self.user)
+        self.assertEqual(len(mail.outbox), 1)
+        self.assertEqual(mail.outbox[0].to, ['new@example.com'])
+        match = re.search(r'https?://[^/\s]+(/\S+)', mail.outbox[0].body)
+        self.assertIsNotNone(match, mail.outbox[0].body)
+        return match.group(1)
+
+    def test_activation_link_activates_account(self):
+        path = self._activation_path()
+        self.assertTrue(path.startswith(reverse('django_registration_activate') + '?activation_key='))
+
+        response = self.client.get(path)
+        self.assertEqual(response.status_code, 200)
+        self.assertContains(response, 'activation_form')
+
+        key = response.context['form']['activation_key'].value()
+        response = self.client.post(reverse('django_registration_activate'), {'activation_key': key})
+        self.assertRedirects(response, reverse('django_registration_activation_complete'))
+        self.user.refresh_from_db()
+        self.assertTrue(self.user.is_active)
+
+    def test_invalid_key_does_not_activate(self):
+        response = self.client.post(reverse('django_registration_activate'), {'activation_key': 'bogus'})
+        self.assertEqual(response.status_code, 200)
+        self.assertContains(response, 'invalid or has expired')
+        self.user.refresh_from_db()
+        self.assertFalse(self.user.is_active)

base-commit: e6040597ae0f614581de241fe78f20e34dae13ac
-- 
2.56.0


