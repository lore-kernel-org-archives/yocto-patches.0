Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D4CA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 15:05:11 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17531.1791471908590049295
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 08:05:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=UMvyh6Mp;
 spf=pass (domain: qbee.io, ip: 209.85.221.49, mailfrom: piotr@qbee.io)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c411d6615so2199975f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1791471907; x=1792076707; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Me++VzPeS1CeOIg1WMuDPuyS6GBpvn9gr4/CsKD7RKg=;
        b=UMvyh6MpWbYA5kvduMtfC7wsimfkKnHwsKq97/DehoyA4GkhmnaZ89Rq8FSz35RYVz
         7FAc5j8Fu0gO7Xr6PRR50ez02HMa7Qk3PgwkDt6qHxaXlU9Vb8gCP089DuG4q3+snV3P
         5xCIIEiN1GUBinVaP71yN+JOH5nw01hQlwFmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471907; x=1792076707;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Me++VzPeS1CeOIg1WMuDPuyS6GBpvn9gr4/CsKD7RKg=;
        b=128WbPYubSD9ITUUf9VjRHSheHn6Op1gXzgmygo2j3fnHcUycz55MipZagZ7ycp8wq
         oKF20U/dEyEoyrG//pFH9vvQiwGom9Ldv41aTB2ZMWxPQr1l6neItY8gGcLnuwPIA24j
         8yeYF0Ne74nrI5TTCnBhtFgknwdYnnryV6/ZqsXfV2ORVx9R8jcbK3oxvWeYmFnvkeDA
         KCT/SbKWOb8w5iJ2dmUGvlBrs4+bsdeuB+ITQi2lgH7+lVxkPgXvWHz/5azmLC8vms5m
         ZdVW3JZ8Ws9XpUfo2KdaS4/FibknuALQYBzJi9LdTt0tpbt9XheHIAu76XB4vOaz3Pi7
         LGcw==
X-Gm-Message-State: AFq9FYJTCF4SVJOCfOESJ2XrTmy3jo9Rmzc7segdBiZTRCiDrYEwrfOx
	TLF9dLhSjEwsZ50oiHQItBZ+b/91KL2DB7gjdPZD0CDubY7BPIToRzV0NeopvVBajwuRx/mVCCs
	J1RLu4UwemNMX
X-Gm-Gg: AYBFou1t0GzdWD7gDFv7CYXFoab2bIpOHYrL4aG/yrJQYxYsay3qeE409sK7j45XDUR
	AYe4fM30pFbP+Fow2eEuFeBxH55jUzB6n/b2HbZLclhCVYb9TTomjeeuH14XR0w83Q5j5W49Hc2
	znomSlJteqAV++HYOF0pTJwz+qLgYDkTmthcwKW3FfQw//yXhkOiQL1j5IuY5yjeVOz7hxwiWUc
	vQIfVMpJN1TCyRPalAozpdPpiMUifPpyDJ9YwrdZV/nr0fcE/VgSGiIbDmzXn5Gq/IOd5h1lEev
	wB9/fU11YxUJGMzmphBaT8Fi7MN7xjzk+Vya8O8mKLPXv2FncXMEgukZtDHBl+sv/T5HeJb7G+D
	fuG26LohXYHWJ7zrQfM1m9i/QNIcymed7ppNLEpODd/aCimb0f8inydYyXTyjGLea+JrE9o6FXT
	REhGMvr312FXmNUM8LfeHOQUoArmdsspR3rmgey+tVAhEOyoz1kFbVFMIkANLUAOgs/C9GxE2XA
	IMagJRxfteY3j8Hm9Pw
X-Received: by 2002:a05:6000:298e:10b0:48a:f432:f266 with SMTP id ffacd0b85a97d-48c7257a5damr8265110f8f.0.1791471906578;
        Thu, 08 Oct 2026 08:05:06 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48db65218desm41243f8f.25.2026.10.08.08.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:05:04 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [error-report-web][PATCH 3/3] Add and use safe_url tag to prevent rendering of insecure link back URLs.
Date: Thu,  8 Oct 2026 17:04:46 +0200
Message-ID: <20261008150446.74259-3-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008150446.74259-1-piotr@qbee.io>
References: <20261008150446.74259-1-piotr@qbee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 15:05:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5001

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 Post/templatetags/projecttags.py | 5 +++++
 templates/error-details.html     | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Post/templatetags/projecttags.py b/Post/templatetags/projecttags.py
index 6c5ed94..a01989f 100644
--- a/Post/templatetags/projecttags.py
+++ b/Post/templatetags/projecttags.py
@@ -3,9 +3,14 @@ import re
 from django import template
 from django.utils import timezone
 from django.template.defaultfilters import filesizeformat
+from Post.validators import clean_link_back
 
 register = template.Library()
 
+@register.filter(name = 'safe_url')
+def safe_url(value):
+    return clean_link_back(value) or ''
+
 @register.filter(name = 'sortcols')
 def sortcols(tablecols):
     return sorted(tablecols, key = lambda t: t['name'])
diff --git a/templates/error-details.html b/templates/error-details.html
index 35bf0aa..5aa807d 100644
--- a/templates/error-details.html
+++ b/templates/error-details.html
@@ -1,4 +1,5 @@
 {% extends "base.html" %}
+{% load projecttags %}
 {% block content %}
 <div class="row-fluid">
 
@@ -67,7 +68,7 @@
 
         {% if detail.BUILD.LINK_BACK %}
         <dt>Link back:</dt>
-        <dd><a href="{{detail.BUILD.LINK_BACK}}" target="_blank">{{detail.BUILD.LINK_BACK}}</a></dd>
+        <dd><a href="{{detail.BUILD.LINK_BACK|safe_url}}" target="_blank" rel="nofollow noopener noreferrer">{{detail.BUILD.LINK_BACK}}</a></dd>
         {% endif %}
 
         <dt></a>Similar errors:</dt>

