Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1891.1794612501000939556
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 15:28:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=bHe3BhVB;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso1505642a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794612500; x=1795217300; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YH2JWvEuvkMYzDBCKE6xDXA1WMt5c0thkiHLiGRkmcw=;
        b=bHe3BhVB8A/4tFMIqMnhr3RfBNiDHV3gZVzgmBYI1RwFtfVouus9+u2xIXl+at6C7Z
         xKPSTZT9gGQC9J4X4RjrVKZOiRjQftbAbSi2H4mf+9W/H7oENrZAC/+qjCBk0KJXoWzq
         qO5deBa7fnORIrMsdmo9wc+2oL0IS+jK4esF4C/6a56DlI5CD570pMJ+YOg1nqUsZBnz
         GKx44tCww7tZaboasLy/I98HWiKnNl7xgOIqnk0/tjyzQkACYND7iffl9leN0884+59A
         qRPqVrfwR6QLw4RZ60OL7+RYAtC05Bv7xSSayl5k28BH2oPJKHZSnnT4xQDBzEujraoM
         /lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612500; x=1795217300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YH2JWvEuvkMYzDBCKE6xDXA1WMt5c0thkiHLiGRkmcw=;
        b=DbUPsRqzE/w0HSXTCMVurTs7mEO0hhGEty+3s7jNtsvYNeeOUS0hlfU2h4YIOQjPv8
         lZl+EQBRCbh/NOedGOmTLas4/QuHIcEtpVqzVGIlKCEoI8HwTX4MnMXduWSxEH0cc8NO
         uwJnIXoQvrAv+sZFAgJ2uSuc1/Xd3hdIn+cqedI+NP2do13ZwBYQnLthY4CWvd+w+H64
         7rj2zLUxfOz2H/ML4ePMZHtAtn3iIUu/nunB92Ixfh9dyFihPGKuLZc3hk+9JDRKtCpr
         w9R3Zf85H0D/nyEBolvYinZtxX6QTpC2a2xZTkfSzNaiM0W3nt5rGnRWo0RTxgJwxE7q
         H7kg==
X-Gm-Message-State: APuU4Z8uR0t+GfTbHNgsiCLl+/Gh2NOl0LcW3QfEAGIErA44KQAerhUm
	6wM0ShTUD3VnQ/o/Y8KNfbvVH8YR5mxYCSoFjQSxKCn/zIKcIN0owtYUqfXlPCPf
X-Gm-Gg: AYBFou2Vj/3s0TdDfhDCKvZYFsjIk+Zm2OR3vqbT46AMhz9SeG9zo1ps2UFTR3ZG9+f
	KODm+XXzilu+e7JBEdzHgN9V30Am8jWCr9s1MlhXvtHnoHtvGMIS8ARpG9UODTtcWHRAiKFQ13e
	ovWBJ5OE9tI6uhnt/HF31w1y8GtRFba+Q+++gQpacCJRT1ZaGxzt5iT6Y0qVUebPS8CMYOdTOfy
	rmEFVX14+FC1R6VbTGFa0h4JXLsEbuP0+6nvJ/+y3IFUwiR3X/FRmBj7tKf1JeCPQjAJeGlGSwx
	lvxWSGOTshAIFgWEvpNmIKKcE2IDZVxgkze8N7eBGnyZ03N60CZG0lqSzhtDcuqaWYSi7o+D30B
	J0zPFB0TRebeyYsNdgcVyp2Zo3cY35D7Jkumy90DokH8934LtxYrVrImAehKPyFSoNoUaUnP0OR
	16MzZ0Ajou8m3kiYirqD+9v5ufHGmxDILuP9Of+HLQ7jHH7Jfo62hP3Py6dAsPJ2gGt1B6aW3zK
	rJzPmWkCwrJ+FSSZBdJdzFEd0ZyV4IQvBG2x7udI7JXk2T6kVtkKGd9fneFtj8D8uapz65CUQ3M
	j7MY8vXMNLXsUNNHDWSbDweU1jgz2w/p/MYaigpI1YlJW0SI14izHWYSXaWfpw==
X-Received: by 2002:a17:90b:8c6:b0:3b1:b66a:c05 with SMTP id 98e67ed59e1d1-3b1b66a0d23mr1977115a91.14.1794612500381;
        Fri, 13 Nov 2026 15:28:20 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1bfb607e7sm1279789a91.3.2026.11.13.15.28.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:28:19 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] requirements.txt: upgrade patch and minor releases
Date: Fri, 13 Nov 2026 15:28:06 -0800
Message-ID: <20261113232808.96792-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113232808.96792-1-tim.orling@konsulko.com>
References: <20261113232808.96792-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:28:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5341
Content-Type: text/plain; charset="utf-8"

Upgrade amqp, asgiref, billiard, celery, click, click-repl,
djangorestframework, kombu, mysqlclient, pytz, sqlparse, tzdata and
wcwidth to their latest releases. Celery 5.7 needs click-repl 0.4.1
and adds a dependency on tzlocal, so pin that too.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index bfc3466..10e648c 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,13 +1,13 @@
 -i https://pkgs.safetycli.com/repository/self-d8782/project/layerindex-web/pypi/simple/
-amqp==5.3.1
-asgiref==3.12.1
+amqp==5.4.2
+asgiref==3.13.0
 beautifulsoup4==4.15.0
-billiard==4.2.4
-celery==5.6.3
-click==8.4.2
+billiard==4.3.2
+celery==5.7.0
+click==8.5.1
 click-didyoumean==0.3.1
 click-plugins==1.1.1.2
-click-repl==0.3.0
+click-repl==0.4.1
 confusable-homoglyphs==3.3.1
 diff-match-patch==20241021
 Django>=5.2.18,<5.3
@@ -20,23 +20,24 @@ django-registration==5.2.1
 django-reversion==6.3.0
 django-reversion-compare==0.17.0
 django-simple-captcha==0.7.0
-djangorestframework==3.18.2
+djangorestframework==3.18.3
 gitdb==4.0.12
 GitPython==3.2.1
-kombu==5.6.2
-mysqlclient==2.2.8
+kombu==5.7.0
+mysqlclient==2.3.1
 packaging_legacy==23.0.post0
 Pillow==13.0.0
 prompt-toolkit==3.0.53
 pyasyncore==1.0.5
 python-dateutil==2.9.0.post0
-pytz==2026.3.post1
+pytz==2026.6
 six==1.17.0
 smmap==5.0.3
 soupsieve==4.1
-sqlparse==0.6.0
+sqlparse==0.6.1
 typing_extensions==4.16.0
-tzdata==2026.3
+tzdata==2026.6
+tzlocal==5.4.5
 vine==5.1.0
-wcwidth==0.8.2
+wcwidth==0.9.4
 PyYAML==6.0.3
-- 
2.56.0

