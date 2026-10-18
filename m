Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACEACCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:49:36 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7854.1792288168856552105
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:49:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=H4HafhbC;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9ae391a05so5465605ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288168; x=1792892968; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vaDBkdfuIrtRUjOlyR8ksc5q+iNQ/gRGuytw/hNwSgo=;
        b=H4HafhbCoYIeCTGwoOOGUVkJyYE6S7lkyRGMerTeKxkZaqQLuf7PdN790HzkpegKMp
         DLcEDzw34GxG6SsssZC8/3ksxecvSRa7VaNtULNurvcRBLUe05fJBJhkwipMfW8rl23F
         3JoX8wog5WI8Mbc7/t6wP8qyjaEWhNZCZfZc5PeJvNMArddxC2RkFDOPAA8PKGqKMeSo
         HcLgm/bn3ZmIbOmOdN8L3tGCakwPWV0FJmr13Orcxbsik0GjPXGqod1d4JMOynw5b3km
         dmm3gbnVCRlKiE5Nk1tkiEddpai+wBHatk5sjjFhzsadn7VuaB45UHaxENOg6PNAx831
         PYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288168; x=1792892968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vaDBkdfuIrtRUjOlyR8ksc5q+iNQ/gRGuytw/hNwSgo=;
        b=FwUqrgBu+ar5vDcF/x44B74Ct2alYoM3HxcCDnxYee79OGBNaOyXfY22+04BtMdq6d
         BLTAbZetumbxv6PL5P36KDQ1k8ROyH1oC+A/dhYL1xszZQscR9AmR2l5krbejntK9z+u
         tPeA427dyzDPOOXpeI8kBeCBtgS4A+Otl7kHdwPFMM2d0FUjBKdZoLOqX+cGelmeoRV4
         8M3Rb7d60Hu9z8FPdjyIN7oRq358e5MB+Al1/ah7C0GYY/zL1ht07+d9Bxvz3LHsRQHG
         nedKdlc5/x14LlvGEIGN0BNpQvIRRc1fVzSrlGY5KwJ6ikei6RuiqqzEumew4J41WnE6
         lI3A==
X-Gm-Message-State: AFq9FYLRfRFsdiywbjEHTBLyUQROSHXpQSwQYM/BRyoop+FWOws4seHB
	pA29aIZYVrmN/hF4z3Yw8z8B67IU02UmpLiL6S08Ru5ow++yWkaSj2Hh8jN1mg==
X-Gm-Gg: AYBFou0/1oCizRyWTjPAqNaQSijTOUNY8kmah4tBye8IefZL4LQqP5Rj+QrB1IXs/qB
	P3DawRpTrPICPmGNrF7zrrdMhXccTlY9NfGywwg2tUOvzPOedvr07xeIOhh+QhIbzqAFeMjdWqa
	jlmf7mWPAeB2zO58GBLnh/dqjnWD3vcjmfQGRjAL2LXhjGAU0jlHsHxR/v6YuQx/OQLvRH+fbnQ
	jH7lssSHZxf3oFpfXfU6N05GxfZ/s1OFPWhfleaaYFgggPNarHksiX6YNXYODPRMzI3CUioYkfS
	m+ILqodRR3Mf3xU1AjnIznh5DVN3Er1PtjFl2BCYBG9a25PfwSvbRVkNE1+3aP51beYh35rMeYv
	lhdZvaU4TN8V6qUuHtdx7Rm1j8ruIsvhT81Sr3DxiYFNZc/WLcng9XFAc66DOXUf4AlgIM67V6B
	HCgZHnnriSLDChqxlSh+vH1V4G1ghfF0R4RUSFCdYuMxIRgGQGcka09PCZLsqgWjPMEea9KV2C5
	LynL5fx/MpMcr0KYTN3DMegz37lX0s=
X-Received: by 2002:a17:903:19cc:b0:2df:9e44:32f1 with SMTP id d9443c01a7336-2e9a6c20a26mr27138535ad.29.1792288168192;
        Sat, 17 Oct 2026 18:49:28 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm25005515ad.60.2026.10.17.18.49.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:49:27 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 0/3] Upgrade to Django 5.2
Date: Sat, 17 Oct 2026 18:47:41 -0700
Message-ID: <20261018014924.73070-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:49:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5050

Django 4.2 LTS support ends in April 2026, so we should be proactive
and upgrade to 5.2 before then.

Tim Orling (3):
  Upgrade to Django 5.2.
  Update base images to Python 3.12 and MySQL 8.4.
  Add a GitHub Actions workflow to scan dependencies with Safety.

 .github/workflows/safety.yml | 39 ++++++++++++++++++++++++++++++++++++
 .safety-project.ini          |  5 +++++
 Dockerfile                   |  6 +++---
 docker-compose.yaml          |  2 +-
 docker/run-tests.sh          |  2 +-
 project/settings.py          |  6 ------
 project/settings.py.docker   |  6 ------
 requirements.txt             | 10 ++++-----
 8 files changed, 54 insertions(+), 22 deletions(-)
 create mode 100644 .github/workflows/safety.yml
 create mode 100644 .safety-project.ini


base-commit: 752b7188d04c2fd0e2f32f0cd2dd437c43058d82
prerequisite-patch-id: 9c9d012e1163dd1d335531d0451657823f17eb64
prerequisite-patch-id: ddb4df3e54736ed25846f91d4918299e601f4071
prerequisite-patch-id: ab69f4aa494291611cbe0e916f18b07f4aeebe57
prerequisite-patch-id: ac2b802ea065536df3854c48e265f5508d201cff
prerequisite-patch-id: 81a7de0e9568848efc8c66d397abb5f56218db95
-- 
2.56.0


