Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2045.1792529868875142558
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 13:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bKgw+e5C;
 spf=pass (domain: gmail.com, ip: 209.85.214.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e977109392so254065ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792529868; x=1793134668; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6+ltMe/m1TVuW6FT7wcTh3/jF8QyOA0hPVWyXIcBlE=;
        b=bKgw+e5Cg8GPFdQ6aw2FC+m2Cr8vpV0sN6sept7B6fAWhFzCnxX5x1aMxlDHBRvF7o
         MMOGORTw/SacNhw4jKqYNNhSnumISwB0lSumw5iD/mk7X1O+DHlLmDLUpY2t5PA/4aed
         sujXShEu3ROaUIQcBGM2xxA0VRMVuha6s998wrr8NoBw6bZHwp7nMT+9lci/iD8bics1
         jYIfH3VgOGDv7mqYkkXIjCpTwx7lOnt+RRB29O+D8l0bKf9NFd1qmTR7g7j88c6WaFZo
         whpr62oKsdnORbcjcDzWk82eWoyjKBX/nFTRTi+wWbzCBLpVk2qg9Ot2bOQZKE338Su4
         Zorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529868; x=1793134668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6+ltMe/m1TVuW6FT7wcTh3/jF8QyOA0hPVWyXIcBlE=;
        b=D4PbwMEYGAABuj51yugs22Y8MT0/VSGB7rxumlT0M+JzmxEXGxuZx+TqYjTvmw5sDq
         w5wGYtFWyPBE5EoG7RTmFARU5dvjSwOegOb36tFVjuHPXAc1h5c/FV9TseX7UYDuLfPA
         g8sCStPlrQm1kS9vvOGSQcii0lrKJo8jmFmRanplRoGcoJb6hOK+aCe93fBtdFio1JJn
         hl8pVd4B6AqvdrSNJ6+e9wIH9eYYx8SfqmK7uwgpqZdXhCJR8XG2cv5MBVWTDFtKiyiT
         Fm+1lggSbCZhtLQw/z+yamD7Ng+moUL+Kox+KezKGy/ejIwJr5vhkXqLLAuDm7YkFUT8
         64vQ==
X-Gm-Message-State: AFq9FYJ54i3TXUjhV3pENmSFVn7+O0XBIjoDhPKJY7Hy6zHgyTRXJQW+
	/N47naMAvg+Ub9EW1rN8jStzcLAm5s/2t5pbnprqPViPJ8KbuKZ8L1F/6D4dL/zu
X-Gm-Gg: AYBFou0+WyhNEeuijUYMZ3NLv/Aeqzue/mFSX7Hb63gff3zG0pvlIPblluAzVjY0PQM
	D0IUZplSj0ExJAKLgLV9qR5wdoh6EjQLY5ekgkdA69dbWYlrQjJZF/cMPRXmUuTeshBnEYk54u4
	NlV0CBOEwvB5RCW0tCbMYdADQPhFcRlS7ASAcbBgRqQhMvvBfC+jKqobcDRKZkSeG3pAo/2p0Zp
	//bAoQ4A6JB3q+LuR5pFmW2MkLJwG02bvSGIkJtBJTQH4qOHlW8VnxPSJlJj6JlwuD3ii3TA2qr
	x4JC2sby4RqOn91DuQu3KMLtkU/U0SiMjnax2KdDIWyI1Eq3XsCRPhNn1y7mziAKZXNgxoWPh0w
	1wTQp1ukgORC2R9g7bySiQsUm2KTMaYZ4ks1TASk3C/08uh/fhQaGUDRXFbasgJaG1uMSmgakDg
	JHV81qW6V4qm8yHf3arombyr+2dCupnyXCuXXvGU01OFE+v93IsJJ1B2Jdz3kI+0u4l9her4Ck8
	5SX2Kabdvfxa+WhhbgHP+nA+IqBHcuJ2i5RkWVX821+oX/t/fa4epK/CgnODFoKajXau0bSv7X7
	DACPKE7FzC6v
X-Received: by 2002:a17:90b:4d09:b0:3ab:2c2b:1030 with SMTP id 98e67ed59e1d1-3ad86e9e4f4mr90264a91.22.1792529868192;
        Tue, 20 Oct 2026 13:57:48 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8029765fsm1039115a91.10.2026.10.20.13.57.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 13:57:46 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] tests: check that changing the profile email requires reactivation
Date: Tue, 20 Oct 2026 13:57:30 -0700
Message-ID: <20261020205730.53370-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020205730.53370-1-tim.orling@konsulko.com>
References: <20261020205730.53370-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 20:57:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5117
Content-Type: text/plain; charset="utf-8"

Layer edit rights are granted by matching a user's email address against
the layer's maintainer emails, which are public. Changing the email on
the profile page therefore must not take effect until the new address is
confirmed: the user is logged out and deactivated, and the activation
link is sent only to the new address. Add a test so this protection
cannot be removed without notice.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 tests/test_profile_email.py | 67 +++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 tests/test_profile_email.py

diff --git a/tests/test_profile_email.py b/tests/test_profile_email.py
new file mode 100644
index 0000000..79e4adf
--- /dev/null
+++ b/tests/test_profile_email.py
@@ -0,0 +1,67 @@
+# layerindex-web - tests for changing the email address on the profile page
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from captcha.models import CaptchaStore
+from django.contrib.auth import authenticate
+from django.contrib.auth.models import User
+from django.core import mail
+from django.test import RequestFactory, TestCase
+from django.urls import reverse
+
+from layerindex.models import SecurityQuestion, SecurityQuestionAnswer, UserProfile
+
+
+@pytest.mark.django_db
+class TestProfileEmailChange(TestCase):
+    """Changing the email address must not take effect without proving
+    ownership of the new address, since layer edit rights are granted by
+    matching the user's email against (public) maintainer emails."""
+
+    def setUp(self):
+        self.user = User.objects.create_user('someone', 'old@example.com', 'pw')
+        profile = UserProfile.objects.create(user=self.user)
+        self.questions = [SecurityQuestion.objects.create(question='Question %d' % i) for i in range(3)]
+        for question in self.questions:
+            SecurityQuestionAnswer.objects.create(user=profile, security_question=question, answer='x')
+        self.client.force_login(self.user)
+
+    def _post_profile(self, email):
+        hashkey = CaptchaStore.generate_key()
+        data = {
+            'username': 'someone',
+            'first_name': '',
+            'last_name': '',
+            'email': email,
+            'captcha_0': hashkey,
+            'captcha_1': CaptchaStore.objects.get(hashkey=hashkey).response,
+            'answer_1': '*****',
+            'answer_2': '*****',
+            'answer_3': '*****',
+        }
+        for i, question in enumerate(self.questions, 1):
+            data['security_question_%d' % i] = question.pk
+        return self.client.post(reverse('profile'), data)
+
+    def test_email_change_requires_reactivation(self):
+        response = self._post_profile('maintainer@example.com')
+        self.assertRedirects(response, reverse('reregister'), fetch_redirect_response=False)
+
+        self.user.refresh_from_db()
+        self.assertFalse(self.user.is_active)
+        # Logged out, and an inactive account cannot log back in
+        self.assertNotIn('_auth_user_id', self.client.session)
+        self.assertIsNone(authenticate(RequestFactory().post('/'), username='someone', password='pw'))
+        # The activation link only goes to the new address
+        self.assertEqual(len(mail.outbox), 1)
+        self.assertEqual(mail.outbox[0].to, ['maintainer@example.com'])
+
+    def test_unchanged_email_keeps_account_active(self):
+        response = self._post_profile('old@example.com')
+        self.assertEqual(response.status_code, 302)
+        self.user.refresh_from_db()
+        self.assertTrue(self.user.is_active)
+        self.assertEqual(len(mail.outbox), 0)
-- 
2.56.0

