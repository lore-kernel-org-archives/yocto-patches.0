Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5088.1794867263178953845
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:14:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fVArgWrs;
 spf=pass (domain: konsulko.com, ip: 209.85.221.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49134c8509fso3858159f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794867261; x=1795472061; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yI0F8rDR6UABRnUBDBuY7U+0LXNsbZw/7KTRV9uYeuM=;
        b=fVArgWrs54k0r26jIHRHwxEIbVyPk5XVmZ+6by61kJ7CxWaurVgEcS+Krg4xqEigtT
         tiY+UPqXDHrQKC6gyFVcYbkSSfmxYRQyrn+r3H1Dw6DPQBkzblkpVPJd792q9/AXwStN
         BVtKH5IaSLUymgVydwZBzQGCvMs/fpO0nkwbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867261; x=1795472061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yI0F8rDR6UABRnUBDBuY7U+0LXNsbZw/7KTRV9uYeuM=;
        b=ftRDdul9AOCMUb97vd6fPHxg0MyNLqbjUAqyRfRB4i2QZKpmxiPjVFXNYXEZCA8pDd
         UgSTfIBhrIo/d94vjx0AMKAPWZoFWjJSgwZnO8YH+GVh66es2cXNmwACXEz7jIHhiyZq
         nO3mqczeSVWS7jtiShmEh3R/2z13wqLlr6ERuE8iDZGWYFqTA4ItowXuBV44A/x1gfJ7
         h7vYECRUv/bHooGr4mKY0MpOwjc/b60kpNG5VTGk6puCYDtzvCmBDgRwFwOGObOSVj+i
         qtUMHUNiFWW6ASbU2ti88el8xBZQJMJiNHCJaeI2ccmAAGD11Ck68thHMZwEYBAA++e4
         VTIw==
X-Gm-Message-State: APuU4Z/RBaLXQp2NQPgSjfSFWjHPr1GS3MI4GlzKqAz6RJueSnCPAkMA
	qute+csuUI8gIHE9V/27bBlYQ8Yqs9ZG67e0Wdml1LUsbYKgk677TADgopeSGIhfgeF0whzxFMz
	zKSJvfwY=
X-Gm-Gg: AZFdTZeCytUl4ISWhGIKBSmf9c8Fe+GFr7pxhftlgI9A8B11IibOGeD6ilG+vo/WtPf
	dbh/zBzryfp5z1Vw1EizSZebAGZICXP8SH0fg7V1MfSmD9MNhp4P7+JYgyBEzc4Dgc/GMXyrjPb
	BKcjgYOj8HAG8DWVBXKL08EQGP7Vh3XIh6GrSyjp/bTdZJY3me1qWzAeY+MHUvS1Lsvyi0NgDCE
	pTfGtLnli7sTbuGFd5+v3ErZZirnwxsecov2VnS5HbMCTCZlPrVbckvFb7L8xGZcgYi74CRhvJ+
	sXVHPGNEicxGVvbgYFao4JyIklsq2I33nGnu4cvTIh/SE2qUiosroSagpEfArOYeSXfXKcpT9M1
	Xpohq/ZL9LOZ5s5oIjxX7jakr1M+SHhm1XL8ghNlTBmF0120Nysg1EwAZphg8ee1fRJAI6phGjp
	opBAcUheBVWQo4OV4XEaMhmjru+1wBOzFPkrdkiqdAuJHvcgN1YOl9LVws81k3D9XM2Y+AetBOZ
	xQF/WM0eV3dQtVmPJr714AJk3QJCT+WOM0+5xQ/is20IHBD1SjIKXlOyx/CHyVrl6UArGa+e+Zr
	66wpFlSMFOmr6Dom97NxkwI1hHoM2DmBi0nk+3icS8z/tPIUJ2ChpvPdD3LYPSqPW9ixmniDCIK
	pwAVo+PJk9+25kb3azKofFDslsEU9JA==
X-Received: by 2002:a05:6000:4201:b0:48e:870:7791 with SMTP id ffacd0b85a97d-49c71e3d623mr29036545f8f.26.1794867260782;
        Mon, 16 Nov 2026 14:14:20 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm24346413f8f.9.2026.11.16.14.14.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:14:19 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/2] A couple of small updates (11/16)
Date: Tue, 17 Nov 2026 00:14:05 +0200
Message-ID: <cover.1794866391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:14:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5426
Content-Type: text/plain; charset="utf-8"

These are a couple of small build fixes to get clean builds on master
after some recent oe-core changes.  I have pushed them to master-next
if you want to try them locally, and plan to merge to master by end of
day tomorrow (11/17, EST) if there are no objections.

Scott


Changes:

Scott Murray (2):
  tpm2-openssl: Fix building with OpenSSL 4.1.0
  dm-verity-image-initramfs: Fix IMAGE_PREPROCESS_COMMAND

 ...key-fix-compilation-with-OpenSSL-4.1.patch | 87 +++++++++++++++++++
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
 .../images/dm-verity-image-initramfs.bb       |  2 +-
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch

-- 
2.47.3

