Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE4C30658
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:40:00 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.27016.1719409192502485226
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 06:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UrtGkrTK;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: gael.portay@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-364b2f92388so4694242f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409190; x=1720013990; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka+pJarKervW2AtnHXeJZbg0IoJ/xsW80I5D8DKSJR4=;
        b=UrtGkrTKNOrdQ90m4NVLUUMWOAhGTbKIGUIiDTWrZRWdd1loSkiMKvbOwEa8c3zriH
         8I+vcedZbeg1bisy0IDsZIUwy2GzOin+oM+lLb0gp+U3HuDn5UIZutAycJsIomvNGX/Y
         GF9V0IGTb1lOmNKTVFiuopdi07gtspXez3/NdIzK+HZYuPkGP47K1sDkgyNGg3OM5xd3
         ZwEXng8Zbh7nrQUYP8P2WxvTZnomePLDBATLkhg6bS2GbO6z59P3BeXLBEG9PCkdV0mY
         mnnJhQdJiy3DZlQEZg5KO/1CdWWtdkAYy2VuqctPeMWlFc3BrBOvCWlNzmP8vX1aK2u4
         DWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409190; x=1720013990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka+pJarKervW2AtnHXeJZbg0IoJ/xsW80I5D8DKSJR4=;
        b=UCrOuC83HTe6FBJNkYNZrA9lU5gbSO76SxGfjpAzPFzg8B8hP8C+UcV7UQPevay4c6
         uinL3YluDKNfMnlYvov3yhvrc42bNOwCkxvW05YmsmgpeuY9KswnS0FToMNkvftVdoPC
         GX3S7qQV9ONAudaLL3bbWqEIW3qyavbwFxhaUCtiD8knckVptwgTBVGV/2T/5LZT6V6V
         LeAIjI6PsJw0GlPwBS4/i4BrY2Dq2bLBunxsLGGMAMgWyjVbDt/yYwS0fVJToa7BvKiP
         zCORhCdf7Ux7B7Hsid+nvlUg2JENndYiVhH/k8sBEtmilkomI2ZIvrGvQIPn7gkzvm65
         5+aQ==
X-Gm-Message-State: AOJu0Yx0M2RKu/eXbJRkkKUwLewpHYJJtOMWzuo1vf7wk+bswpSNGf0w
	b1qyj6ImEdChUVo5Knb/oODKodhW+I35ipn7gXAWWQn2KHct65/JCukv8UV4
X-Google-Smtp-Source: AGHT+IHD1eHBOp870y87GEEUD6G+vj7lniPm3rdl7JIT5XsJiXSnJCKEW+Y5S36X3TrNujTiHw9Ucg==
X-Received: by 2002:a5d:5f8e:0:b0:366:ebf5:c6cc with SMTP id ffacd0b85a97d-366ebf5c746mr8267556f8f.50.1719409190249;
        Wed, 26 Jun 2024 06:39:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm15802533f8f.95.2024.06.26.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:39:49 -0700 (PDT)
From: "=?UTF-8?q?Ga=C3=ABl=20PORTAY?=" <gael.portay@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security,kirkstone][PATCH 2/5] sssd: fix ac_cv_prog_HAVE_PYTHON3 value
Date: Wed, 26 Jun 2024 15:39:10 +0200
Message-ID: <20240626133913.790145-3-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626133913.790145-1-gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 13:40:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/376

The variable HAVE_PYTHON3 expects a boolean value[1] and the configure
script raises an error if the option --with-python3-bindings is set and
if the value HAVE_PYTHON3 is not "yes"[2].

The recipe sets a non-boolean value to ac_cv_prog_HAVE_PYTHON3 and thus
causes the task do_configure to fail.

This fixes the value set to ac_cv_prog_HAVE_PYTHON3 by setting it to yes
instead of $(PYTHON_DIR).

Fixes:

	| checking for python3... (cached) python3.10
	| configure: error:
	| The program python3 was not found in search path.
	| Please ensure that it is installed and its directory is included in the search
	| path. It is required for building python3 bindings. If you do not want to build
	| them please use argument --without-python3-bindings when running configure.
	| NOTE: The following config.log files may provide further information.

[1]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L323-L325
[2]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L353-L377

Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
---
 recipes-security/sssd/sssd_2.5.2.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
index fe82452..98a4b5e 100644
--- a/recipes-security/sssd/sssd_2.5.2.bb
+++ b/recipes-security/sssd/sssd_2.5.2.bb
@@ -41,7 +41,7 @@ SSSD_UID ?= "root"
 SSSD_GID ?= "root"
 
 CACHED_CONFIGUREVARS = "ac_cv_member_struct_ldap_conncb_lc_arg=no \
-    ac_cv_prog_HAVE_PYTHON3=${PYTHON_DIR} \
+    ac_cv_prog_HAVE_PYTHON3=yes \
     "
 
 PACKAGECONFIG ?="nss nscd autofs sudo infopipe"
-- 
2.45.2


