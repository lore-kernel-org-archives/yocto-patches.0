Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1812.1794612495158766710
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 15:28:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=DeGffZfb;
 spf=pass (domain: gmail.com, ip: 209.85.215.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1483833a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794612494; x=1795217294; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5D3wnyWD9NqH56xK6zwrxIG0tQpTiuBOTkNCJ5S19M=;
        b=DeGffZfbhBxMckMeO4XYbzigcmr5HyhK521TK7vfscfqBloNCCg30cPh0mzhgsRCaK
         qZi+x7WJNnadFdi0lK6/FF5VEgPtLUJ1Yv3pNmBMSzDSL7aTm03BEWBR5B/GXIApJXXZ
         WSq1Jj+WE6WM3yJRTz0AevceF6jqnycdm5FoX1q8Uj0XfX7Taj4V6AcnSjXsxXP75Yb+
         MRUD3sdBODJFAxysOkJ9ilhnLio4kn1YP6S282x9WlSdouqKthYfQv/gISNCgzl4rivr
         6gsvd2IQcMkUZE8dau6uPTeQqGQl04yCitzBceOzwaZVAabg791neOp/W0MKteyeUc1f
         95cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612494; x=1795217294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5D3wnyWD9NqH56xK6zwrxIG0tQpTiuBOTkNCJ5S19M=;
        b=Gc4zqfHJhFwVVm9hF/a3xSiL7h5D7pJSFdp6AAslA94vdtIkI1ktrEiafIPH/ZXbdT
         jqVgdeQb9hmkb+hP1K5xCt3qn4LKIvwhSqZXftRBOvzX2J5quzpA+q8imOj3PwZel9Vv
         k10f6r4BPe+bNg75KMtBsHOEZMLnoDIdcwsw6nPNAdZoO1u7mTkQ4i3GvNlIgFYf/ZNG
         LlVWOuo4uKaPLhqTjcgF8ooEXV8hthdSw8CqbjxxleNNeWnV0aCauTInlDyjKrQ2fZME
         GmSZBYgeNv0y5vJFGQkqC6kqbdYpgVuTsMZK5UzPiNMSAjIdu725OMS+yzimJXVc3IOf
         1OvQ==
X-Gm-Message-State: APuU4Z+nXdDsB+++NmUXFcCCtfx0+AVbirqgiOBQjiWR79BJfGu0YF+N
	+Q0XD9sDqTsV2dSZhceRuiwu/Y6zkPN7v3ZkN2SGEe5nm1WuemLTq0mDUTxdJw==
X-Gm-Gg: AYBFou16axigTpMMSG1EQUBBDLI5EZfxFpvu1hyxVIqLGhOoDsucdo0u6myxdr/94t/
	pKSIyYeujX3cd3uaIbhUCbhV/H9VbTBuUrsh4m2woW6G6BT9y3cXQwF/PeDISYAFDMohfAnEd4K
	U9Rr2yUH/oGr3cyVh4MXAhU6p8Ro7gH2glMJh0tk9p8/h8JOaFRpn3OmNCKunDdQJpvejQjbpvr
	PacMNUnxLjRkPHZkTq07t5iTKAj9Cu1PgGwVPdnV+xPTRsU1mDCWEiwDm3j0+BuaeVEFX6/QqpA
	uCUgBk4RfKK6KG2q0SLdoTWxlllpRljHImVofPgrWljCM166r4V5enVLSHpkUr1VUjXR1qjDSyP
	zMOc4CprFOWWDfk4BviG3/nQUTWuHy4V2Y3+Dka3mxTg97X2nnZGFiBbwD9FJt3i6zR0e8vY32m
	Davzv00Rgzxcju7fjtxz5kV4gXLaA2CRbl9Ec7Y/5ITFzoYpRs0VMpv+8P8TGP/6SjyWEMWpxYG
	rU8SORvkm5HDmExTSZFh9BEWcMc9zDECjtPYwSK2DEPQU+JIewZw96I7q9UikHB8uywTLI3wyHl
	z7usy5qNF9NYB9XiKJY+Z3MwOxYfGlhtpkBRFqJtShqiyHtV93xEUmVIXTxI9g==
X-Received: by 2002:a17:90b:1f81:b0:3b0:a38a:6715 with SMTP id 98e67ed59e1d1-3b1b0d753ebmr3791952a91.59.1794612494368;
        Fri, 13 Nov 2026 15:28:14 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1bfb607e7sm1279789a91.3.2026.11.13.15.28.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:28:13 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/4] Dependency upgrades, and a fix for site notices
Date: Fri, 13 Nov 2026 15:28:04 -0800
Message-ID: <20261113232808.96792-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:28:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5339
Content-Type: text/plain; charset="utf-8"

1: Fixes four advisories against soupsieve 2.9.2 (CVE-2026-126190,
   -126191, -126192, -126193). Soupsieve 4 needs Python 3.11.5 or
   later, which the move to Ubuntu noble provides.
2: Upgrades the other dependencies with newer patch or minor releases.
   Celery 5.7 also needs click-repl 0.4.1 and the new tzlocal.
3: Writing a test for the only use of Beautiful Soup turned up two
   bugs in site notices: they showed a literal b'...', and a notice
   with an attribute on an allowed tag, such as <p class="x">, failed
   to render.
4: Adds tests that run the Celery tasks without a broker, to cover the
   Celery upgrade.

The full test suite passes in the Docker image against MariaDB (83
passed, 1 skipped), and the series is running on a test instance
loaded with a copy of the layers.openembedded.org database.

Tim Orling (4):
  requirements.txt: upgrade soupsieve to 4.1
  requirements.txt: upgrade patch and minor releases
  layerindex/utils.py: fix sanitise_html() for Python 3 and current bs4
  tests: add tests for the Celery tasks

 layerindex/utils.py |  6 +++---
 requirements.txt    | 29 +++++++++++++++--------------
 tests/test_tasks.py | 39 +++++++++++++++++++++++++++++++++++++++
 tests/test_utils.py | 13 +++++++++++++
 4 files changed, 70 insertions(+), 17 deletions(-)
 create mode 100644 tests/test_tasks.py


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

