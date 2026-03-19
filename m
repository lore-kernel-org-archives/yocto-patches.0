Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A21088E62
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 01:36:10 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1854.1773884164864484167
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 18:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JT/DtE+q;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40946982a78so66702fac.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773884164; x=1774488964; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9r/khhukeB5IKtKMDiIo+x3pfjVvIYarY3ety1fLTM=;
        b=JT/DtE+qDRztomKtvFAE30K0d4C/ugH9f4XAeNT+kWwBWtIUnO7fd9evmNOKG45cxe
         MbUaS3yqe2oITIfj5eHm1cxPRqTqu0fA3qR5syjIfSq2tqqD5k68bpGGaDDcZm0iw0XU
         253VPDNRJO8MqpzaZOsCOBHF+OpyPqaFjIjHYM4XZQRzXvWeyrEzQqgwv7PeywmKUZyu
         2S1ZydSxlyo84Bq/Hy7oDlGs4VP9zC0lEzY/7g3tLh4wYbEj4Q2vUgXwUwcyci2dRm76
         v3XnkoEniFiLe8dQY1nQOIZaNQwtefhyNmSkxwmsknUKPPuTdX54cBKsW3TOxX2bMkAw
         j0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773884164; x=1774488964;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9r/khhukeB5IKtKMDiIo+x3pfjVvIYarY3ety1fLTM=;
        b=gAmF5LmsBuv6e6iha1LfuFnDKHHLg/Z101UQ5M2mSH+AHJY7hcTA8hiF8DVerXPQ8i
         pe5aRJkquvoIJGT7Fa2/z5p4C5LvnBgr1wotfI/DfGrAVu6+zjvwz4APP9HxveujPOyX
         k30fU/qNnxxUY7iyH0ARMf/9YfUPq/rL06MFmFwexruAjpfB2eQSj22+uXbIc8/mbZI+
         A/gIP72QLLYAtsPRFKLyJQ3JBORdbnj64G2R9YwYB69mjvPU+IMNDCYSHOS4oe8aggle
         OCc2+k4MGM9AWKdGj73WeSWUlJfBTXZ9WCvdEgir9vETSAZMzGUlr1fpjqPRTsfj5vWZ
         sGKA==
X-Forwarded-Encrypted: i=1; AJvYcCUEZita9l/o5vU+1jijzWMhUE4mGlTiHWFsN3znyjOZqAOPOlC+3SOvHISuDLwI31fhQkMTSjg1riwU9u/u@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YydBsG6AKAW2XwJ34YvX20WVx6Ue0viS+bSP6I8exvgKmRzl3yf
	X0vl+vTc2K0GuaEs+oQICoUi5Rr0lJXldVnXOCA92u8onXw1fFYmcUbJ
X-Gm-Gg: ATEYQzyOWk4XRT8BDaAkH9s2+druqAgfbe6Sqi63yjf0WxP037300STb3z7EBHpkBpf
	Zl5359II1gaOCxem6HHpgzeUAPcjGWMj3evbJwkZxRkjj1c6PPso0Pp6MzeGpViCZygrNJeQOXl
	oxHb6PTV4SF3sZSCP9OIhs3Qp15zRWiqiPaPvNEkiliFJt9no0bS77w00qBEjKPFgBNOHNEK059
	oI+fcQnEGINf+v7x7iu7kwHEG4bLPOwZWD4MK5MWQe5sTKlajYjP1io7TFWkugUdYsdYIQ57agY
	YW1qRPmM1JpPTuZMYsGDD6joPl9IS8xKiigUSu9zG0q0gtgoijnKaiedXunvaht5bGgFwj5hSS9
	SmKuy40xgEnZ8MQ6Z08UG7Eq533Pw6FcyEekRHOspNkAMN9LKo9R4fGJd56tAUO2l/fhDiz1AxE
	MGgibEkA+bvBQq6Yd8zHq7ajTyx+D2fOi/66H5p72IO24ovMRoUBXykP4QGHu24hP28p/q+zSTP
	Nlw
X-Received: by 2002:a05:6870:1791:b0:417:3767:bf11 with SMTP id 586e51a60fabf-41bd413ca69mr3307417fac.47.1773884163796;
        Wed, 18 Mar 2026 18:36:03 -0700 (PDT)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2c2eabesm4195928fac.9.2026.03.18.18.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 18:36:03 -0700 (PDT)
Message-ID: <b7680b5a-775b-4684-8219-00b9346b4602@gmail.com>
Date: Wed, 18 Mar 2026 19:36:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yi.zhao@windriver.com, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][whinlatter][PATCH] refpolicy: add auth_create_lastlog,
 auth_delete_lastlog
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 01:36:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3517

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-authlogin-add-auth_create_last.patch | 61 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-policy-modules-system-authlogin-add-auth_create_last.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-policy-modules-system-authlogin-add-auth_create_last.patch b/recipes-security/refpolicy/refpolicy/0060-policy-modules-system-authlogin-add-auth_create_last.patch
new file mode 100644
index 0000000..17a7ab5
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-policy-modules-system-authlogin-add-auth_create_last.patch
@@ -0,0 +1,61 @@
+From 7c65b04395acf164874731a674335e1b543c3a7e Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Thu, 15 Jan 2026 16:26:29 -0700
+Subject: [PATCH] authlogin: add auth_create_lastlog and auth_delete_lastlog
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/1f0dbdbef203295d2c7f968608697121f18af348]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/authlogin.if | 36 ++++++++++++++++++++++++++++++
+ 1 file changed, 36 insertions(+)
+
+diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
+index 35e6e7c2f..bb282024c 100644
+--- a/policy/modules/system/authlogin.if
++++ b/policy/modules/system/authlogin.if
+@@ -1073,6 +1073,42 @@ interface(`auth_rw_lastlog',`
+ 	allow $1 lastlog_t:file { lock rw_file_perms setattr };
+ ')
+ 
++#######################################
++## <summary>
++##	Create the last logins log.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`auth_create_lastlog',`
++	gen_require(`
++		type lastlog_t;
++	')
++
++	create_files_pattern($1, lastlog_t, lastlog_t)
++')
++
++#######################################
++## <summary>
++##	Delete the last logins log.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`auth_delete_lastlog',`
++	gen_require(`
++		type lastlog_t;
++	')
++
++	delete_files_pattern($1, lastlog_t, lastlog_t)
++')
++
+ ########################################
+ ## <summary>
+ ##     Manage the last logins log.
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index e65edcf..b69cc31 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch \
         file://0058-policy-modules-system-logging-allow-miscfiles_read_g.patch \
         file://0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch \
+        file://0060-policy-modules-system-authlogin-add-auth_create_last.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

