Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA57C77B7C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 20:10:52 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.25834.1750882249380026772
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 13:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=F8sQyh/T;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fae04a3795so4100146d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750882248; x=1751487048; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8mKAsSM/aKMrtnKTvZ4l1h841fpfvIS16qba8U1DE8=;
        b=F8sQyh/TuZ6pt58K0YcgCmOMpb/lEmPhB07c0XU3NZdw/N8ZjEAbAHgnDEguMosgV9
         cmfitkJ7CKAA/gzMJkrngpyuNG4hXSl++JkHcvt9egTck5XeKAUaWY9la4vVgOar9h1i
         O901TjWuCpUlfOA9ijrx9EIohqloxOYLvEjFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882248; x=1751487048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8mKAsSM/aKMrtnKTvZ4l1h841fpfvIS16qba8U1DE8=;
        b=E4tZNZx+mo7PFRFXPr8BPEOOoDhvHJTtV6U3gHilpgu81qd44iZbpjMolOWOKU2w+j
         tJwa3K/MZaPKc9O8ye466HRA8ZG0ZwR6vc3OHtQwS9iWmLn1nV3HCQSeIK0jKrBavWHO
         UFp060q82Rblgey77lcSrHS07xaXN1XL0/gks38USlSlF9+A45LKbnUGUV7APi6+wQ6r
         FfeA4oDYeQrxvYR4nPpFKlzkqhhJXmwl6motJpwb35jze+uK8hRatLgW+Tbj9+m7OtVQ
         PA837ToTVRJIhRXIzw/qQ3MMpCuIVuJV8QF3e7250h9qDvJ9eaNaXDhh/e5qCRydo8qZ
         utyw==
X-Gm-Message-State: AOJu0Yyx5rqm65qRIYn/hXFKT85tMs3pZalxuo7fxCCXSS+tZ4K+H5hM
	fj3ma6LNuQkM6zknNZ7iQy2rgLAMqQrtRRu0jgOUlzq0F10RmMCd6LgShNlX2zGqcv4ioN0/E3e
	SEP04
X-Gm-Gg: ASbGncvLVrfEaQ1B1g6t860r8CAK1FsNL6lj06Es5WY4HsrGj1y5dCK+vykBQvRYgGI
	FRhVYHSTj+TM3EPwXLJxf4rMbQdtAFGs9FuWu4wm3AI0wbFAGTvCNRZxMNFRwquZ+bXi38kNbqX
	Q3pLkYWm/XXcHxmonTCUXvG38IAf+WGO3cpUYArMCuWUQ6AcGSVCm/fwQVNBUa5+SCwejsPG+nT
	uq9MbbVw/mjgQs4V1WrJpeFeceKHv4OF9YStZpYrhJLNyKbDbbz0ANy7p1Mao6KiZC3YZ2VnMGN
	BwKCA9wLl7FJCrx+xbwc4TafEjED/7n2d4D7MjDRD4nt8foZvMb0wz3sqg5UzHhMG6n4cFgLdIb
	CPkQwfIb614QNXNMItCru/GprgBytoIz404xRDA==
X-Google-Smtp-Source: AGHT+IEYRJSUN9cFfYiKLkvhLZ/EwcmM0hWwtcYikV8+ga9D2SjsrJY9yR+5OHOI0R1hxACE8cWSCA==
X-Received: by 2002:ad4:560f:0:b0:6fd:7508:9c04 with SMTP id 6a1803df08f44-6fd75089e0cmr12927296d6.20.1750882247845;
        Wed, 25 Jun 2025 13:10:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093e0578sm72299646d6.10.2025.06.25.13.10.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:10:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 0/2] Updates to fix building with oe-core master branch
Date: Wed, 25 Jun 2025 16:10:32 -0400
Message-ID: <cover.1750882005.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 20:10:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1692

A couple of patches to handle the switch to whinlatter and adapt
the recipes for the subsequent S/UNPACKDIR changes.

Scott Murray (2):
  Set compatible layers to whinlatter
  Adapt to UNPACKDIR changes

 conf/layer.conf                                     | 2 +-
 recipes-security/refpolicy/refpolicy_common.inc     | 2 +-
 recipes-security/selinux-scripts/selinux-initsh.inc | 3 +--
 recipes-security/selinux/checkpolicy_3.8.1.bb       | 2 --
 recipes-security/selinux/libselinux-python_3.8.1.bb | 2 +-
 recipes-security/selinux/libselinux_3.8.1.bb        | 2 --
 recipes-security/selinux/libsemanage_3.8.1.bb       | 2 --
 recipes-security/selinux/libsepol_3.8.1.bb          | 2 --
 recipes-security/selinux/mcstrans_3.8.1.bb          | 2 --
 recipes-security/selinux/policycoreutils_3.8.1.bb   | 2 --
 recipes-security/selinux/restorecond_3.8.1.bb       | 2 --
 recipes-security/selinux/secilc_3.8.1.bb            | 2 --
 recipes-security/selinux/selinux-dbus_3.8.1.bb      | 2 +-
 recipes-security/selinux/selinux-gui_3.8.1.bb       | 2 +-
 recipes-security/selinux/selinux-python_3.8.1.bb    | 2 +-
 recipes-security/selinux/selinux-sandbox_3.8.1.bb   | 2 +-
 recipes-security/selinux/selinux_common.inc         | 2 ++
 recipes-security/selinux/semodule-utils_3.8.1.bb    | 2 --
 recipes-security/setools/setools_4.5.1.bb           | 2 --
 19 files changed, 10 insertions(+), 29 deletions(-)

-- 
2.49.0


