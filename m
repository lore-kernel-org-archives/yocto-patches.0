Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5903.1794631241952822837
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 20:40:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=TJbclb2j;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so1804650a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794631241; x=1795236041; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeVC2bg+YUEJZqEaGXxfM6G7LbtMz/PZhZFFrJXhU7U=;
        b=TJbclb2j9O16p6CCzNTU4p8ouYJ4MzRVMCTfM6L8aKJVObG+K4CC6trjuUQIzXbUzF
         s3vBCxhOkwAgCkyjCIJ7hp0zxGSCKAeEoTux4MPyOVN1CO8rj2++cnqFauXbj0S51quQ
         bCBj/NGD88kIO1u3ppYW4RaITzu4kZfaTUB4KgKEEPwHXZJK0VfNMb3MWG+i6yREUXeY
         jPLHRp5l03wID120Zoa39EN1iSXCnBeeT9EcnXzIjBSgzRCq6c3E1Ux5kzqKiMsCoAbn
         YmE1bX1W2xNLWwFVcdDVJBYTypieS4bn6sre/IuCepSg9WHVGyc4n9h8j2nUbWdZOtkR
         bk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794631241; x=1795236041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yeVC2bg+YUEJZqEaGXxfM6G7LbtMz/PZhZFFrJXhU7U=;
        b=KqY3CcOilNuU5rki0UqM3y6dlj83z7wP87DbRexuga9TE69O3F4++OCxJRBh4YQS3H
         5WusOaPSWy+LWDPnwOySXkIIXgNdZcUfKrFU5bgoxRm1tqt/uhoPcYgNKoqn77P3SHTk
         GcwD2/rlIvoMooVb3V5gqv1M1U6E9SCV59Z0hqAdsq75N3MlPkjfURLC/HK95es3sfHL
         /25RE8N3vmac+GLcTUNCCpy9kFFvvJqvFJoFY9U+lGE20JLQx6AH2LlwxncmWx+8f/QO
         GCRWnVgKoxSEw2ahRt9Q+p88EZv8I3dg3o1MYsCbIXEXFwA4/4COY5S5dk2XUWl902Lf
         3BCg==
X-Gm-Message-State: APuU4Z9nHatZSMuVdzG9hvz1SWLCL70oAP0VndADmMnxpU5MPgC46qd1
	ow3cLsWY/LK1Ah7qNs1JnEVtqJuRx2hz/uMl1qyS+vWMRrny0wPH1sexm7Dhvq6L
X-Gm-Gg: AYBFou0gMMjArDVqpdZV45/bG1EVArupvGdt3TqvoiSApJMS1uyXr1rzro/8Nieg+wA
	g8GvVLoZerWv1iFnpAZdJ0yNDoLM91+oHE09APLL3HVf8vwgXkXWGzNU1EqA3Try1DWCPJTJ2by
	Hb0DpesXcbJ8dYJ5Wu78lU5UKpDswyDA5ClmKNV4sBLsqqINJQhmuBOGR0BRT//cI5wUCoJTs1S
	HR0Xv90qyJO2cPvWOODuYiu6z0mSdJWF+iBL0ZQq4r7iDcOB63yYQ1KfjpVl4vmsZ5OHjHTT9uE
	ozyK8EqsZOmfnRlnH/3DHAZPawtdcKeSBsyj27O19OKJ0UHLtlhTFuvmLauC6FBg39op6YpJ61c
	gp6yMG6XTMcGdG2WFWUew2oRoW5DqslRPkIyxLaH1jkQVyem/JhzCobKBWGdWN5iEPOZkh3Icyb
	73WeAx/Vpl81TdZ2fsElYoresMKI3x9iTT7y8oGKfmy1/hRJOIiaxPg+hZpLx8C6xc6r7TJHl6s
	AGrkxSYzp6qR1CRd7FCBcHVGW8GaZZ8flTxsDSYLxU8Wslaqv5YodqXZv9/8axW+6TgMaqU2F0a
	uilCIqAJnHIbLWav5r/VUD+btEXpo65TcutGIydUjd4vX2cQvxl/BgAVuOHSYA==
X-Received: by 2002:a17:90b:1b01:b0:3ab:2d46:1dd6 with SMTP id 98e67ed59e1d1-3b1b087a23amr4339429a91.4.1794631241068;
        Fri, 13 Nov 2026 20:40:41 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc186fc72sm2165693a12.5.2026.11.13.20.40.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:40:39 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/2] Fix parsing of layers like meta-luneos
Date: Fri, 13 Nov 2026 20:40:33 -0800
Message-ID: <20261114044035.88470-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 04:40:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5364
Content-Type: text/plain; charset="utf-8"

Image recipes in meta-luneos fail to parse in the layer index with
"NameError: name 'oebackport' is not defined" (bug 16192). Two
independent problems lead to it; each patch fixes one, and each on its
own stops the failure.

1: Bug 16497: update_layer.py parses each distro configuration file
   into the datastore it then parses the layer's recipes with, so the
   recipes parsed after luneos.conf got LuneOS's configuration. They
   are now parsed into a copy.
2: Bug 16192: the BitBake server, which parses the recipes, never
   imported the libraries a layer adds with addpylib in its
   conf/layer.conf. Their addpylib statements now go in the
   bblayers.conf it reads.

On a test instance loaded with a copy of the layers.openembedded.org
database, luneos-emulator-appliance.bb and luneos-image.bb on scarthgap
fail as reported when parsed after luneos.conf, as update_layer.py does,
and parse with either patch. Dry-run updates of meta-tegra, meta-qcom
and meta-luneos, which use addpylib, give the same errors and warnings
with and without the series. The test suite passes in the Docker image
at each patch (77 passed, 1 skipped at the end).

Tim Orling (2):
  update_layer: don't parse distro configuration into the recipe
    datastore
  update_layer: make addpylib libraries available to recipe parsing

 layerindex/recipeparse.py  | 23 ++++++++++++++++++-
 layerindex/update_layer.py | 13 +++++++++--
 tests/test_distro_conf.py  | 47 ++++++++++++++++++++++++++++++++++++++
 tests/test_update.py       | 20 ++++++++++++++++
 4 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100644 tests/test_distro_conf.py


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

