Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65064D0C5E0
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7396.1729844571827448695
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L+M/rnDW;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1696815e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844570; x=1730449370; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29fBmAmNDh6174whbVpxpcipTREYv++TD4sf/MESwQk=;
        b=L+M/rnDWsspnVfkCHNMa3JqrAHksAprTx5uUChtYzKwXUglHXfuTC+4NGeFEZPgB3C
         z3lxKS8nM6Qzgns9hTbacPP3wF4MvvftLX/f86pflH6Rop8IJZ8mVTcZNWLZq3iuRnHW
         vK8nS9NQeQL3rpDQs6fHEC1yYUiV/TWlOVFfiD0m3RpysFwXNps0rZP/55HSWnMjWKvy
         h2tx1jl7OMSjGVXRTtssUmu8fUqiDxH1Tj1XY/ul2eMYGOpkvPmU0fV7Xol7Hjxhuwx3
         A4fEeIhOkvurtxrTq9oeCkM+xSidcg1hEkpydvh1DE/+VFInzLJjrCAHHHgJ/QUn4sl5
         5UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844570; x=1730449370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29fBmAmNDh6174whbVpxpcipTREYv++TD4sf/MESwQk=;
        b=AFWKUdEjfmoJh0Zcqb4aYujkx1+Zph/s6T6JAOS6KcCpor8VmUrZCooIANo7uBoAVa
         Er2IvKMmOOwUQhA/it3wBavtfX9AZyf/JdnBXSGMoGpT17AZVrfkFlkYAQiPX7YklDWu
         a9SfQwIjilin+V7/Pcthii66TM5X16BYeTF8RFpD0URQeT9KDAQPAz7QBZFTIjY46VCH
         /978dWazVKtay4fROrZo004dCjoagrVbzWEQJKGjapof0etfmgX1UDLREoSyGiRF57sK
         fU3TXh5lpROIF4lwVT7BVFDh1ghewT0oglt7eFPr5MLowLFrrjGuLn9P9A+O/vLM6fx9
         LD9Q==
X-Gm-Message-State: AOJu0YyagkLr+/WWQqaDWYWCAu6RCRRucKGVTvl2SfZ4JbgGYR4uABhw
	6B66Dg185JtrPCJAXzRnlTMPQGUUMnZzJ8xeyzzsVbbo6Gz1E/rCf3CMtwOF
X-Google-Smtp-Source: AGHT+IF798tgOVeewQLQ3+o0z7fUkw7nAlBZM9GR4qtHHonnXpvY5cZ8L9mNCABZSTc9Tcau5YQ6CA==
X-Received: by 2002:a5d:5f94:0:b0:37c:df55:c1a5 with SMTP id ffacd0b85a97d-37efcf49d6cmr3222492f8f.6.1729844569719;
        Fri, 25 Oct 2024 01:22:49 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:48 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 05/10] sssd: fix ac_cv_prog_HAVE_PYTHON3 value
Date: Fri, 25 Oct 2024 10:22:34 +0200
Message-ID: <20241025082239.3468351-6-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:22:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/753

The variable HAVE_PYTHON3 expects a boolean value[1] and the configure
script raises an error if the option --with-python3-bindings is set and
if the value HAVE_PYTHON3 is not "yes"[2].

The recipe sets a non-boolean value to ac_cv_prog_HAVE_PYTHON3 and thus
causes the task do_configure to fail.

This fixes the value set to ac_cv_prog_HAVE_PYTHON3 by setting it to yes
instead of $(PYTHON_DIR).

Fixes:

	| checking for python3... (cached) python3.12
	| configure: error:
	| The program python3 was not found in search path.
	| Please ensure that it is installed and its directory is included in the search
	| path. It is required for building python3 bindings. If you do not want to build
	| them please use argument --without-python3-bindings when running configure.
	| NOTE: The following config.log files may provide further information.

[1]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L323-L325
[2]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L353-L377

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 2035cd0..2717e4e 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -39,7 +39,7 @@ SSSD_UID ?= "root"
 SSSD_GID ?= "root"
 
 CACHED_CONFIGUREVARS = "ac_cv_member_struct_ldap_conncb_lc_arg=no \
-    ac_cv_prog_HAVE_PYTHON3=${PYTHON_DIR} \
+    ac_cv_prog_HAVE_PYTHON3=yes \
     "
 
 PACKAGECONFIG ?= "nss autofs sudo infopipe"
-- 
2.47.0


