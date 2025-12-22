Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841FE677FC
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:23 +0000 (UTC)
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.84025.1766422339443957668
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kSkxD/WX;
 spf=pass (domain: konsulko.com, ip: 209.85.219.66, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88a3d2f3299so49533366d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422338; x=1767027138; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqv7SSDDwI6Up2sgv/6n6psTrrKrZxfW1oXkLV/Ftww=;
        b=kSkxD/WXcRwoGX2z+d4nEZiTreTGXNpi2wy0YtquTMer1DziY3l0tMo1yVEs0/ePKm
         M94b1utzfcqrNuA3nsl7TtQ0dhWCQpn0hvD3UBL8VQsVoYAiwc2PhILSZ8PWvCNhRkws
         OexP/te1FF63zk/LggJkn9kePKrwdRw5tvwcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422338; x=1767027138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqv7SSDDwI6Up2sgv/6n6psTrrKrZxfW1oXkLV/Ftww=;
        b=El3hlHEzzuB9wrvavqKXBBIQ3UTl1vfOnfIe0hbZ97mmUjksl4qjWeYpvdk8FbGG49
         hssNYKcnz+Obj4zasHlW8w5dbHUOgVnhVnAB9nLR+6n95ADMgKllrO52PS0pbMhsaVbJ
         B1hj8aMQTuCul9ph4rKaG4OiBzk3WjQ/3y6HmfW8r/rAt7cL979xEytRxq/m9TfwJRjy
         904DnEr0DnU1EsraZvPxhgQmdRqUDtDUdXN5/aXHRUdxjc5IMWgAASYZoLwVX/fq7/qx
         6A27AsX6NxqF7TnPxmV8UP6ZnreIgEDCKAfDySS20rKnWub3ttvj529+CvgvpJrnnzw6
         G/zg==
X-Gm-Message-State: AOJu0Yw6Qyp0ym1TEOKjbDbqLEvyQrM0lJMVbrzVZoJAO5q+3r77dMdD
	i1iknYMDXF8s+zaTAROX2NC1o+h0AfSMn9IkmM/b5hBNrPVeZ74oc8sjLh0nxhwFaacf4og5eUf
	u4WuSdYQ=
X-Gm-Gg: AY/fxX4VzqofYhk7Az/4jXI3H13ATVNbFxrN0CQpOsasTU6JgmtmFFtp/u1+rH0Xtxm
	c3llsaLitVdLKIEXvca3RR4rrow4oVX7OTVE9eYJeZoOWpqbW7qArjFQi/65gie2tJ7TNBi72Pc
	t2+rYC8iMTrnBEnecqjBZm0ZChDfeipIwQB6I2R8dFMIah7iO6k6jSGhY+ACaFpPJ6ow9m6UbaW
	h+pPsS1wCps9b4FWV9zBiMDlQ+C0F8UB2wXTRawshDjITh4ijTSrQez10zuXCCDKwRdd/AqCQg/
	pg62xl4jOjz7jsue9YdL/YCyYbChA6af6DxI0BlM2WU7RGXCOpErEPKf/4OEfCUsdzzJZVN2fPN
	8QreZ/uv6CEjtc7G4i8iZHSOSXrxlwb1dX9VKVvS/ZbZYXl4zhlrgihldc1Bb4GTzifnEvk9U/L
	39Q07TMpIeCF0mS9yyWnigZE+PsNe+GJkUlUYv+eR+c15WiLroAQWDElJZIQ7bCdAf/1DYWNaU6
	EbvhPjwv5kcGa0xEHn9bqSRzPe85NxOsStc3BvmzuFsJtxIOLX8
X-Google-Smtp-Source: AGHT+IEi5CmXb9F73evd+qLEUpfoFFfpQ+KgtjR+wOUmpF0bIebtn7J9JPd6vclRkV1RurtQR6h+Tg==
X-Received: by 2002:a05:6214:5d06:b0:88a:4391:59d4 with SMTP id 6a1803df08f44-88d86961f7bmr161432986d6.51.1766422338136;
        Mon, 22 Dec 2025 08:52:18 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:17 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 0/8] Assorted updates 12/22
Date: Mon, 22 Dec 2025 11:51:48 -0500
Message-ID: <cover.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2850

This patch series rolls up the contributed patches from the past few weeks,
a bump of suricata to 7.0.13 that I worked up, and after a bit of rework
to get it passing CI the contributed update of clamav to 1.4.3.  Note that
I had to disable building clamav on all 32-bit platforms due to what appears
to be an upstream limitation/bug.  If you need it on a 32-bit platform,
I'm open to carrying a patch, but a fix would ideally come via working with
upstream.

These changes are queued on the master-next branch if you would like to
check them out to test yourself.  I intend to merge these to master branch
at end of day tomorrow (Eastern Time, Dec. 23rd) unless there are objections.
I also plan to create the whinlatter branch at the same time to get that
going.  For scarthgap branch, I plan to look into backports of newer suricata
and clamav in the next week, but we'll have to see how that goes with older
Rust.

Scott


Changes:

Clayton Casciato (1):
  suricata: drop deprecated nss, nspr PACKAGECONFIGs

Hemant Jadhav (1):
  clamav: Add recipe for version 1.4.3

Scott Murray (2):
  suricata: update to 7.0.13
  scap-security-guide: update branch

Yi Zhao (3):
  libmhash: add UPSTREAM_CHECK_URI
  sssd: inherit github-releases class
  scap-security-guide: add UPSTREAM_CHECK_GITTAGREGEX

hongxu (1):
  openscap: switch to libpcre2

 .../recipes-security/sssd/sssd_2.10.2.bb      |    4 +-
 recipes-compliance/openscap/openscap_1.4.2.bb |    4 +-
 .../scap-security-guide_0.1.78.bb             |    3 +-
 .../packagegroup-core-security.bb             |    6 +-
 recipes-ids/suricata/suricata-crates.inc      | 1437 +++++++++--------
 ...{suricata_7.0.12.bb => suricata_7.0.13.bb} |    6 +-
 recipes-scanners/clamav/clamav-crates.inc     |  286 ++++
 recipes-scanners/clamav/clamav-git-crates.inc |    9 +
 recipes-scanners/clamav/clamav_0.104.4.bb     |  156 --
 recipes-scanners/clamav/clamav_1.4.3.bb       |  236 +++
 .../clamav/files/headers_fixup.patch          |   58 -
 .../clamav/files/oe_cmake_fixup.patch         |   39 -
 recipes-scanners/clamav/files/tmpfiles.clamav |    1 +
 .../clamav/files/volatiles.03_clamav          |    1 +
 recipes-security/libmhash/libmhash_0.9.9.9.bb |    2 +
 15 files changed, 1279 insertions(+), 969 deletions(-)
 rename recipes-ids/suricata/{suricata_7.0.12.bb => suricata_7.0.13.bb} (94%)
 create mode 100644 recipes-scanners/clamav/clamav-crates.inc
 create mode 100644 recipes-scanners/clamav/clamav-git-crates.inc
 delete mode 100644 recipes-scanners/clamav/clamav_0.104.4.bb
 create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb
 delete mode 100644 recipes-scanners/clamav/files/headers_fixup.patch
 delete mode 100644 recipes-scanners/clamav/files/oe_cmake_fixup.patch

-- 
2.51.0


