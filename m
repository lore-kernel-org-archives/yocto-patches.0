Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EED1039A
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.7377.1729844575346223846
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cVkMNKgF;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d6716e200so256051f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844573; x=1730449373; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFiqJV8QVG9O9oQY2zf8U65kMnCKN0YO3DPRA8684cI=;
        b=cVkMNKgFWlsWUT9lg9VNch/Foe+XtQthafZ8YBAOiaTZ/ENlvb75X1BXp5NpakgbmV
         bNl87xbwReHFHm3cMoH977NUGO5KN42LhFd+umdvVuVyy7eqdpr7ktuvoRirUgg+XeAp
         BbHn1nobSDlhgFlkqEsbzxwUcylMDMRrxAXePRxDG2zG/eo0Yw3XrTfJ2eBaLtHayuzn
         J7d4rnfHxWfrdqonr9jLYxbvR3SSccOzWCRXoLUT7GUxNnwSiSliRWucORKz5nXCjs6J
         gPq5gb0ulapFRDxwpBFcP1vPNy2iKESBrag4xSf8xaMiHQYSOxLjMLcKR7/YgONFq9fx
         QNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844573; x=1730449373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFiqJV8QVG9O9oQY2zf8U65kMnCKN0YO3DPRA8684cI=;
        b=HJGW04Ft1Bse02+k+lh7LMzRZKuM+OuEWJMxxBUdEUZea7T6lots2/2+H0+VGYAA/x
         IWwaftvb5tI2sEMUXjYwzyRQahxDMxnW/QY8xQEBdz+J+roBQJo1QY8NRo9H8HJ+fOgh
         LNgqBmz4XTVXXrRoEgWQ+MRmsWVRJbS5eMFwOB9RipgYKF7q+5E33dNan4sKYRTF6pcF
         dzd8di8kEK6xIh06LKCyZPRFk+2cpaOlBsw88jWjT0Z0DMxpyg7z/zMjWhnWj5OEcxj1
         azbRafgCVOWdSIH8DhVGbcWCwsbtAQE/e2rZyAA8Q7oIX+HvxKBOK1DFbhoeggl5X4YP
         Wrmw==
X-Gm-Message-State: AOJu0YzP/IEFgdQ/OJnBSaZ6dAPptkpgCCbF38WPY0V5ibuqcouVCpWD
	oLtjpJiQY8ekGKd37Bux8casl/bCv1+V49+0kTlEjvCSpbuQ8ReLMI/Lhh/b
X-Google-Smtp-Source: AGHT+IG3eXFgF24xX8xoul4Hj6ExKeQNTPX/aLQafe0GA3PZru1OW3sYqNyBiFYwjqpDt8KPfn29TA==
X-Received: by 2002:a5d:6d04:0:b0:37d:47f6:6fda with SMTP id ffacd0b85a97d-37efcf636bbmr3163192f8f.7.1729844573246;
        Fri, 25 Oct 2024 01:22:53 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:52 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 08/10] sssd: fix missing python3-setuptools-native dependency
Date: Fri, 25 Oct 2024 10:22:37 +0200
Message-ID: <20241025082239.3468351-9-gael.portay+rtone@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/756

The Makefile runs setup.py on the target all-local[1].

The file setup.py uses the deprecated module distutils[2]; sssd-2.10.0
has moved to setuptools[3].

This installs python3-setuptools-native to fix the do_compile issue
below:

Fixes:

	| Traceback (most recent call last):
	|   File "/home/gportay/src/build/tmp/work/core2-64-poky-linux/sssd/2.9.2/build/src/config/setup.py", line 25, in <module>
	|     from distutils.core import setup
	| ModuleNotFoundError: No module named 'distutils'

[1]: https://github.com/SSSD/sssd/blob/2.9.2/Makefile.am#L5462
[2]: https://github.com/SSSD/sssd/blob/2.9.2/src/config/setup.py.in#L25
[3]: https://github.com/SSSD/sssd/commit/9efd79b010dbb46d9968c3d3ab073b8e585cb2ad

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 6a74a51..a3b1659 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -54,7 +54,7 @@ PACKAGECONFIG[manpages] = "--with-manpages, --with-manpages=no, libxslt-native d
 PACKAGECONFIG[nl] = "--with-libnl, --with-libnl=no, libnl"
 PACKAGECONFIG[nss] = ", ,nss,"
 PACKAGECONFIG[oidc_child] = "--with-oidc-child, --without-oidc-child"
-PACKAGECONFIG[python3] = "--with-python3-bindings, --without-python3-bindings python3dir=${PYTHON_SITEPACKAGES_DIR}"
+PACKAGECONFIG[python3] = "--with-python3-bindings, --without-python3-bindings python3dir=${PYTHON_SITEPACKAGES_DIR}, python3-setuptools-native"
 PACKAGECONFIG[samba] = "--with-samba, --with-samba=no, samba"
 PACKAGECONFIG[selinux] = "--with-selinux, --with-selinux=no --with-semanage=no, libselinux"
 PACKAGECONFIG[ssh] = "--with-ssh, --with-ssh=no, "
-- 
2.47.0


