Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DDCCD1A2
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:55 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.1669.1760649766976898208
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ih7X95do;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7f7835f4478so13842116d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649766; x=1761254566; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGUwKeH9eKZ8dtxIckRE5wW3QL7y/4ubB37CeEWEZnw=;
        b=Ih7X95doVxYy/DwImteV/qPEtKyuxF9xsZrzosKqbz96zOZrg/rgtV9FdR3jrw24gJ
         /J4jNfFPkNn2hVOT4X0M5mEqVRIYXGW5Kow7lRclDKksy+x8fWEp6TBM1fHpRC+mHppJ
         n04A3CL1rHGSqEcLVnunQaW0gJY8jrzhdgYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649766; x=1761254566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGUwKeH9eKZ8dtxIckRE5wW3QL7y/4ubB37CeEWEZnw=;
        b=Gdbk0RLv1r1vkHRHDFo7uLKT+XCNkpFguOThZ4pk5E40csokxC5t9XNtr2+RqdYlPn
         swulDM46soxD4OqnjN2OUmzuVZ+Ixnhy3Beog4oEoi5SnEXoXMpyXP3tL6Eakw1E4rpD
         TusE7JJctv/f0TBS8KK2SfcQQHTk3+nQeBCpH/KOeyQt1B7HFrqeKlnkII2naEBCwSWS
         iZlpLF/t3o9Bt5++HG0D3EDYIbQXgWSRKJqMw1vgAWCR7XgALGtLglwN6SW3aI267uMG
         BOlEzcqrZkG6tEbcw0YAD7vBEQqz13JYW/gzM3kio0rr1grhno1xhO1psFg+LsTeO0GH
         Dw+A==
X-Gm-Message-State: AOJu0YzosLjGlgvGO3F/ynWoNoGetVsOM9Ch2cMBSnTayu0AMRUQlKXV
	nUB4b2bvD3lIo+DUnyAV2YvslFqcUtYAJbuBvB3zWW8LCOdu/N/1acYA8OBUMXcTX7J7+HcvX3I
	lyAi2
X-Gm-Gg: ASbGncu2QF3uu3yyEMVYF+cIhUFq32gbQHuJTmURV04jjEp6TUih8WCv3bFQvza2pJ6
	/FocXi38q3amCeacz8uy8nmixz0PFvLwanKGkGu/j45XLvXQaL8nn+YApmAEhxQ0GWY+AFCjtHZ
	hRkwld9IDzzYB3K8yFsqHSyKE7WrMk9Pdwgwp5iAAvorCOIeW+sceywrI/Xul1U8bnm7PNu5AB2
	2xUJ1fuEwC223oyHy+aOqX2Mg1KdrEmNVj4YM5ufLN05MsAThZZcQqhlK5rjzyIFI23OhArjcXM
	I2pOPavfvv1LhZv/YaPL5ds2W4v/dL0YbzqsymsuJmwE/NBakXW9auLDSpbtSmNiTftnca0VCo3
	pQuxpBnG2uD/dM7b1g6Y3sanTSP8kmC9Yw/cypVv6iZEYwxms248mTvRxHhSjk5hh5veH39zydh
	kRPQHcFlGA26e1797e4hKHPJQCHE4YBuUbGageEGDgvm9Ot6akqi+dm+VbFRyJp8I=
X-Google-Smtp-Source: AGHT+IH1umu9Q3SxZRdcflOBhTh10j9iOjvFq9ZzbDvMysuaSQFsKC+bsctkQlaaiROhTi/E0mFM6g==
X-Received: by 2002:ad4:5cab:0:b0:87c:2360:d415 with SMTP id 6a1803df08f44-87c2360d492mr6745006d6.24.1760649765737;
        Thu, 16 Oct 2025 14:22:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 15/15] meta-tpm: Small maintainers fix
Date: Thu, 16 Oct 2025 17:22:14 -0400
Message-ID: <16a3042a25e4a3e9df8999f97a4d6d2efc05dde7.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2340

To avoid confusion, remove stray aircrack-ng entry as it is actually
in the main layer and not meta-tpm.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/conf/distro/include/maintainers-meta-tpm.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index cbc1fcf..0ba4f1b 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -19,7 +19,6 @@
 #	RECIPE_MAINTAINER:pn-<recipe name> = "Full Name <address@domain>"
 #
 # Please keep this list in alphabetical order.
-RECIPE_MAINTAINER:pn-aircrack-ng = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-pcr-extend = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm-quote-tools = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libtpms = "Scott Murray <scott.murray@konsulko.com>"
-- 
2.51.0


