Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3989DC3ABC0
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 11:10:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.73263.1746529828814161510
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 May 2025 04:10:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7221054752=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L8saV032469;
	Tue, 6 May 2025 11:10:27 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c1321p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 May 2025 11:10:27 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 6 May 2025 04:10:27 -0700
Received: from pek-cli10-d2.wrs.com (128.224.34.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 6 May 2025 04:10:26 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <richard.purdie@linuxfoundation.org>
Subject: [error-report-web][PATCH 1/1] settings.py/settings.py.docker: stop using already removed settings
Date: Tue, 6 May 2025 19:10:24 +0800
Message-ID: <20250506111024.1597505-2-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506111024.1597505-1-changqing.li@windriver.com>
References: <20250506111024.1597505-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=6819ee23 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=ArP49Si0AAAA:8 a=t7CeM3EgAAAA:8 a=A1X0JdhQAAAA:8 a=ebRHUbsqYRWChfjIAloA:9 a=ATClE4nxGrkA:10
 a=glZLBWN_5F3qvmUqPDV8:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: W883_tv57Z-sbAzcPXv-4qGiwWbmVATm
X-Proofpoint-ORIG-GUID: W883_tv57Z-sbAzcPXv-4qGiwWbmVATm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEwNiBTYWx0ZWRfX6eTpolJJsNV2 ULH3PO23QpSXM/aQCx8L8bdR8cMXzAQE1o/hGGDKKBIec0/aQid2LSHOuxE9CQbNhY8UqadQ6nO VyCtI3EbMfzFsqLGDbwIWH6Q9BUzAWKSnW4CE0bzrGW5HhnCEIaVjeBuAY3f0eTyhVkffnAYvPJ
 h9D0S7aRiwOZ/umRt6kqeWfwcaahB91x3z7ojStvPFTfTahSr0Oa6PaudnvaeSF8xojaKtujZYB HeKIuTOL7VdwV6DbqM/itXeYKIpiLowgJeVCDYMhfehK+vXwydBHnqwdfMjB9EG+ZSNjGc/29Id U2XcX1cGeB8qiQG1HRgF5J9wQwHvXbnKFOpV0fDW9aKcR+wiC6rUA9Z5KdepoIpcDMjpokLeyGa
 LoxtZKnzErE4CzB2c6r9nXlbHyuhOo43/TwHlmCDhigTLVse8l5RTQWY0jaG9BNCMiujHB5u
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505060106
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 May 2025 11:10:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1520

From: Changqing Li <changqing.li@windriver.com>

TEMPLATE_DEBUG/TEMPLATE_LOADERS are removed from Django 1.10, refer [1].

Test steps:
1. Set ALLOWED_HOSTS = ['*'] in settings.py.docker
2. docker-compose build
3. docker-compose up
4. docker-compose run backend /app/test-data/test-send-error.py http://x.x.x.x:8000/ClientPost/JSON/ /app/test-data/test-payload.json

[1] https://docs.djangoproject.com/en/5.2/releases/1.10/#:~:text=TEMPLATES%20setting%3A

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 project/settings.py        | 8 --------
 project/settings.py.docker | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/project/settings.py b/project/settings.py
index a0697ea..d0d8279 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -7,7 +7,6 @@
 import os
 
 DEBUG = True
-TEMPLATE_DEBUG = DEBUG
 
 ADMINS = (
     # ('Your Name', 'your_email@example.com'),
@@ -114,13 +113,6 @@ STATICFILES_FINDERS = (
 # Make this unique, and don't share it with anybody.
 SECRET_KEY = 'changeme'
 
-# List of callables that know how to import templates from various sources.
-TEMPLATE_LOADERS = (
-    'django.template.loaders.filesystem.Loader',
-    'django.template.loaders.app_directories.Loader',
-    # 'django.template.loaders.eggs.Loader',
-)
-
 MIDDLEWARE = [
     'django.middleware.common.CommonMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
diff --git a/project/settings.py.docker b/project/settings.py.docker
index 8ba0b55..4dcb58d 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -7,7 +7,6 @@
 import os
 
 DEBUG = True
-TEMPLATE_DEBUG = DEBUG
 
 ADMINS = (
     # ('Your Name', 'your_email@example.com'),
@@ -108,13 +107,6 @@ STATICFILES_FINDERS = (
 # Make this unique, and don't share it with anybody.
 SECRET_KEY = 'changeme'
 
-# List of callables that know how to import templates from various sources.
-TEMPLATE_LOADERS = (
-    'django.template.loaders.filesystem.Loader',
-    'django.template.loaders.app_directories.Loader',
-    # 'django.template.loaders.eggs.Loader',
-)
-
 MIDDLEWARE = [
     'django.middleware.common.CommonMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
-- 
2.34.1


