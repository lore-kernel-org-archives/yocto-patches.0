Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11BF3D613
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 17:11:18 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33123.1774804275132156339
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 29 Mar 2026 10:11:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=gbruQ5K5;
 spf=pass (domain: qbee.io, ip: 209.85.167.45, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so4296712e87.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1774804273; x=1775409073; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWYy+T93EIIar0rKrB9teQpNxYpVxivbCqtpLCSIr7c=;
        b=gbruQ5K513vB7uDD1cWbwJENU2OTGdQgmNMO0EyyHOIiUSO/Lp2yIMVTdyoGckBFOO
         pnvT2mXB74hbLxUAZL3bl6y8uUuIK0sZCHPRct6Xw2WYbzv+X1NvPrePEDWrGib1kUCZ
         DedONWQgHsy8Asd+jmn4LdzORmpu1hdMNiR+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804273; x=1775409073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWYy+T93EIIar0rKrB9teQpNxYpVxivbCqtpLCSIr7c=;
        b=o8Di+E70q7Rv7B0czrOfpZAVugV47B11DAbokW7WgeCnm/qAZPp9mQYWmtIgA0Z1I1
         XEVKdJgNNOQWBbwn+SlBz2YvmZXKZcWoVIZ5N84umY/GhM4K20tdGYnmN/dNXh5I5kc1
         ZeBiK6RYR4Vcxd0gMAtWEPoqT/rv8LgZg2VMUI68IsR//Y9cNUYALB/lOUwbt6z1CYgd
         WmxqldoMjHCa4ynoK3u9WtwhToaOG1L3XE0EADzqrriTL/ahiJhi5p5Mda1yWhNzPTM8
         XHdbslQ+mFQDJ1Ok8ZKNsM1/KVEzF2IE2QAJJnHhEEDJeXyKawv69kgzuc4HrzkVsKkc
         hZXg==
X-Gm-Message-State: AOJu0YyQwa4exyUdumGqKwv7v/A/rla8+tUccPjL/EsYl0sOAsTAkfQi
	rpnvK0c+IaiDZQcCJqjU3JbEyxRy1C9axopFzLXHwHw/aViZDnj5Vw3L1Rh9hZLNRSaXqdilCe2
	L9OyYLJCVmg==
X-Gm-Gg: ATEYQzxvWAw0WAOeL8bDNJ357Aj9w1MkwQPfAuu4BxsLBEDJYqSnY/pqYJOzxZllYGz
	aPcSt6780u2fKczGLnO0DXCtCAJ8OjEMi2P+94bMQd8pl+GxRBOvPKOk7pe3onEKpoqQe2Jn0QW
	/0DK81gTnH1lZ72Ya6HGtGUDhAquqVoDx6juveuocAGZk8BO/bTT5i4lAsXwqKz17dFjlrMMf5Z
	1KPxDZKjyQB4MN91tMTWs2tK2ZUArE38nQLea7Akygkml5jVmH+F029UIxnGVg/cuBxvVtdiIYp
	qZw+a2iOdBqlV2t40m0vVNnjo1h3h7QxCpGc9Lp+GyTFFoPFgAvO8BAi1gWeaD6F/3wcrEkLCGw
	ZuaFdZi16ZAVpTQihyUKpVqmvo2j9O8xjouMmpKUGqYvC9bCR92ThZPAxHpCzQq9KWjy2MouG9z
	xIoHEw7itFIxzM0YCV/5ZVaJ1hHnvnXSBBXzeZLetngN5aZGMScJNpENnzR8aBQpw=
X-Received: by 2002:a05:6512:3a83:b0:5a2:b43d:ac47 with SMTP id 2adb3069b0e04-5a2b43daf66mr928778e87.5.1774804272529;
        Sun, 29 Mar 2026 10:11:12 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-38c837349dfsm10400601fa.17.2026.03.29.10.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 10:11:11 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH 1/3] Convert logout to a POST request, as GET is not longer supported by the new Djang 5.2 TLS.
Date: Sun, 29 Mar 2026 19:11:07 +0200
Message-ID: <20260329171109.34764-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 17:11:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3575

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 templates/base.html | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/templates/base.html b/templates/base.html
index e167139..e31238c 100644
--- a/templates/base.html
+++ b/templates/base.html
@@ -30,6 +30,7 @@
 <body>
     {% block header %}
     {% autoescape on %}
+    <form id="logout-form" method="post" action="{% url 'logout' %}">{% csrf_token %}</form>
     <nav class="navbar navbar-default navbar-fixed-top">
         <div class="container-fluid">
             <div class="navbar-header">
@@ -53,7 +54,7 @@
                             <b class="caret"></b>
                         </button>
                         <ul class="dropdown-menu">
-                            <li><a href="{% url 'logout' %}">{% trans "Log out" %}</a></li>
+                            <li><a href="#" onclick="document.getElementById('logout-form').submit(); return false;">{% trans "Log out" %}</a></li>
                             <li><a href="{% url 'password_change' %}">{% trans "Change password" %}</a></li>
                             <li><a href="{% url 'profile' %}?return_to={{ request.path }}">{% trans "Edit profile" %}</a></li>
                         </ul>

