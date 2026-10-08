Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730DCA600B
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 15:05:01 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17757.1791471892061562415
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 08:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=bZOb6rj/;
 spf=pass (domain: qbee.io, ip: 209.85.221.51, mailfrom: piotr@qbee.io)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2828919f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1791471890; x=1792076690; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awPvRpfRI6OcBlmP7XFd/bJGrNJRdWPUGOhBZFd3uvI=;
        b=bZOb6rj/HMeSrF1Yh51g6MPvaxdrNOV7ZbKwjnE/nQS4B6rUPsgGy/4cgWwEHLq/u2
         bWwqgLTjtGAjsYzTZ1zdRWIe4SWiiBC4zL6lDsXDn2bccAqrJ6Kyc8D5FqicskGYa1C7
         YDIClKvagaw95yDCx/8rOjK7Sbiq5tuBEItmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471890; x=1792076690;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=awPvRpfRI6OcBlmP7XFd/bJGrNJRdWPUGOhBZFd3uvI=;
        b=NDundyiHEH1kia7QHeT6CTUWgiDdHWuxuer/iXzhc8s578+katoOF7Fmc0DwZnwai+
         XpymzcAg7IOw8QmASLVhgv6GHhKhfQ1E4bKnDvFlrwfGS+n2AAN4dEP/XLgQBknjKQ+P
         +VhTtNVxegUjz40aOgqA/TTyjJYJEHo3O4PSg0fxW1tUgmkFvUe8AfgJUkvvRT/qHIqe
         NhI9QKpjf/46VPJM55XkqD+2Fou1K/CSvKjKvI0uo+N5b33iWrI4k16Dyk8FM5QgESXa
         +es8MfekBo/xT8J6vMH/uEA+ZtSyz2+ei9begfIdhW8biA5N0a0Mq47Stqoq16wyBvkp
         I4cg==
X-Gm-Message-State: AFq9FYKC43XDfRmG7xGt0NF+i+NnCCgbHAycvDl5sSiUKCEr/GjUg3wZ
	KwJTSdBByMGN1O5gUsX1Az+aclc7yzdGYadAMpQ4ZLA0fejGSP6jxyNZwCN9s5aPa6s+zh8lYLg
	oXz9A325L6Rfb
X-Gm-Gg: AYBFou2c0CSh//examlayTvmlpGftI8TlmHONDmpH63+HA+p4nnhPf1Hhe3PR8KySRl
	7+bN9CztaopG4VUVPlDJcdluxoQnr4taijYU6Gc4u8E/qm/laPH8GXUT1Lu/3QhvURD0bZBXM2F
	7RsFnIft0CtMMI72yk8kRQnZbd32SAIGnFWnAXTkXlmF7KGNG5EAL7lvjJBKg3Ux4HMC9NNtYn+
	r71B4gq5EzSZfdz05OVzHX3PiIzOvF1/0yiND/FOu1Ncp1pjybg0HCEiv+tyDRJp7FvUhEhLFrG
	Mh1wxKkzx+ErBhZRWRGhz/cjEss2vnEVeeQjTnfOj7sdFDkA/8hYnx0XcgEi6S5blLJ9XbTYasC
	xTlf3vPSeA69mXd7iUDlwOEq8IYXdZjchICmNlJFjbEdoxNdwuZ/vdJHIdzc9CX+AzpLyUMJ/yl
	sOn+YnmHVSIJgk4nqNJvD0VIXUXr+vBpSamgjV373m8B3f1urFPH574yMeXqYInjKnuOhM8XV/h
	cqktwgrEOcMFJZ1/Qzm
X-Received: by 2002:a05:6000:470a:b0:487:2443:7526 with SMTP id ffacd0b85a97d-48c72896f85mr11475321f8f.55.1791471890014;
        Thu, 08 Oct 2026 08:04:50 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48db63ce3a9sm94706f8f.5.2026.10.08.08.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:04:48 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [error-report-web][PATCH 1/3] Fix existing tests to establish a know working baseline for future work.
Date: Thu,  8 Oct 2026 17:04:44 +0200
Message-ID: <20261008150446.74259-1-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 15:05:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4999

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 Post/test.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Post/test.py b/Post/test.py
index 5acb68e..15aa4be 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -2,7 +2,7 @@ import unittest
 import urllib.request, urllib.parse, urllib.error
 import json
 import re
-from django.test import Client
+from django.test import Client, override_settings
 from Post.models import BuildFailure, Build
 
 #Delete the data between tests
@@ -65,6 +65,11 @@ def compare_db_obj_with_payload(self, bf_object):
 
 class SimpleTest(unittest.TestCase):
     def setUp(self):
+        # The test clients submit with HTTP_HOST="testhost", so allow it here
+        # instead of hardcoding a test host into the project settings.
+        override = override_settings(ALLOWED_HOSTS=["testhost"])
+        override.enable()
+        self.addCleanup(override.disable)
         self.client = Client(HTTP_HOST="testhost")
         self.client_0_3 = Client(HTTP_HOST="testhost", HTTP_USER_AGENT="send-error-report/0.3")
 

