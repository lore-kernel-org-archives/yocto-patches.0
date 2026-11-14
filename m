Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6483.1794635546582340515
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 21:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=kePrG2iV;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so1981888b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 21:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794635546; x=1795240346; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Zd9iOnEIfZFf5LlEBxslxkV2EBiL3lnZdSBbw5e6kc=;
        b=kePrG2iV4epushc6Q36nAEI3mhBqoG/mBIo70iPQMDQRLJAkw8f+sMd9ZHJvFgnKyo
         +X5rszqP5eKIRI3XB9QsegPQVoEu0D1CfwH5Ix2E/IzLkhS/MTSJiQ7Ugfa8ihkj5ikD
         NxkECOVkWCZnEui25xer8ppGx+K8/F+k4ocIzgVsdcFn3iOI/77u4f4LY3qRJNVKkwwW
         H99hXBcFcwOq1uHYYKEv5jILzAXEMkcooXdZU9iGYXJeobR69OhPbbEEFRQoGfjEhpUf
         mZLVwIMheZvtneCFSHtjPsqAESvQ1Mzi2vMRBWuuafB5p9hkX8dCPIQBnsquWquQWs4I
         bihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794635546; x=1795240346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Zd9iOnEIfZFf5LlEBxslxkV2EBiL3lnZdSBbw5e6kc=;
        b=smxBndtHZMaUpHBvU8IKToArAcEm4RqcuAaRYgSiXD7grH6NQEbhFdMg1qXxIzEbRe
         t2TBg7i67fOzcdb6fU2gQkB+PtK3D6ize+Cj/F3zS+TbuQeXaXp3E+z0xk92Ej3O0jin
         wlyEFZ8k0b2qRR5Pdih1J7B9HxkOgGsfk6cv6q5Iuq+Fss2JezTHHSTi46FKLGQG3nPk
         LTyLJvvN6nxIk/Pf0WVSDgwikwhKHXusbCA0Vfs+LH434L5DP8YNpFGzkGgxhBevzg/P
         jqYz/WA3KwdFhoI0j7ss4bNrmyuJbDvCmo74HypMTylz6hZlhVvPFFXyd++E5GPKkBrq
         dmbA==
X-Gm-Message-State: APuU4Z8OB8Wetl+hwsUItQw4glcp7USzJWFzCc41RREO394pPImdN+cf
	tgIHbV/tAGx50bRuBgmXdlVfU72odm+uSUljiUSD+32CLNC6U9PYNaI35X0PT1YN
X-Gm-Gg: AYBFou1VXNN4YppkPw/178qiw+ukHpcejTQ43ieAbWhKVNgW2kjr+ep/0pzZRtLiICW
	mqkv+z09sgddwyxLtdi8LWAhMSsMP98e2nGI3DfY4999aqWVmU5phrjNbocIY/Gtcm071HUI3ec
	PcwGjeSQvpIC//xstv74f2xWYa0l5jQIWjRx8vuofVPQrYTMm5PaH3FLsNY8niyRdqWm9kNhNKp
	2bxzUHqD7MkOv1GkBtKzeBCb9CncPDCPUQ8RLznKljT5fGgPJU9yZF1nMcbswiAAG+BCePbwLus
	viA89Gu+vbcG69w0yHK+E/HV42ThN/5k20KIuHVeXVXChzrICitWoLNu6NrxmRnV6Rz/2smb3dH
	eHpq6LeeXmT4HkNmNzPqJlr88V7XI0JQE+QbyH0l5xfAMsEdu/xy50Rc3xtPNzPXQmGwnGWulx7
	sDEzAsi6UbVR4EVeD/sjjIqSwwnP1VRluHsQd6TKL+pD0jlwrJQFyK6S2wxLH0IjCli44UMkh7X
	1Tv9fhIcwt33Zx41FOkiPJuEsPE6ImVFSnRJaHBONH4xjntVHExTweSdhRvQ2dvpgmGh9OeIepR
	5CceXarDGVxK7gf/Te66bbOBozmVKr7GzA/OclAr9n/tmwhuQFVmbgNuZs2lt8E=
X-Received: by 2002:a05:6a00:929c:b0:89f:1b32:29a5 with SMTP id d2e1a72fcca58-8beb20cec32mr4810088b3a.7.1794635545890;
        Fri, 13 Nov 2026 21:52:25 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2635285sm1957746b3a.44.2026.11.13.21.52.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 21:52:24 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] layerindex/views: require login for the profile page
Date: Fri, 13 Nov 2026 21:52:15 -0800
Message-ID: <20261114055216.2636-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114055216.2636-1-tim.orling@konsulko.com>
References: <20261114055216.2636-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 05:52:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5370
Content-Type: text/plain; charset="utf-8"

The profile page had no login check of its own, so a visitor who was
not logged in got an Internal Server Error (500) for both GET and POST
instead of the login page. Require login.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py         | 3 ++-
 tests/test_profile_email.py | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 592311f..35186e6 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -19,6 +19,7 @@ from django import forms
 from django.contrib import messages
 from django.contrib.auth import logout
 from django.contrib.auth.decorators import login_required
+from django.contrib.auth.mixins import LoginRequiredMixin
 from django.contrib.auth.hashers import make_password
 from django.contrib.auth.models import Permission, User
 from django.contrib.messages.views import SuccessMessageMixin
@@ -1001,7 +1002,7 @@ class HistoryListView(ListView):
         return Revision.objects.all().order_by('-date_created')
 
 
-class EditProfileFormView(SuccessMessageMixin, UpdateView):
+class EditProfileFormView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
     form_class = EditProfileForm
 
     @method_decorator(never_cache)
diff --git a/tests/test_profile_email.py b/tests/test_profile_email.py
index 79e4adf..57feee5 100644
--- a/tests/test_profile_email.py
+++ b/tests/test_profile_email.py
@@ -65,3 +65,12 @@ class TestProfileEmailChange(TestCase):
         self.user.refresh_from_db()
         self.assertTrue(self.user.is_active)
         self.assertEqual(len(mail.outbox), 0)
+
+    def test_profile_requires_login(self):
+        self.client.logout()
+        for method in ('get', 'post'):
+            response = getattr(self.client, method)(reverse('profile'))
+            self.assertEqual(response.status_code, 302, method)
+            self.assertIn(reverse('login'), response['Location'])
+        self.user.refresh_from_db()
+        self.assertEqual(self.user.email, 'old@example.com')
-- 
2.56.0

