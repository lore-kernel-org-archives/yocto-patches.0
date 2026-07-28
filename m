Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35642C531D0
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:37 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2420.1785202893818908489
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FfJ8OFVA;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3387293b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202893; x=1785807693; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OWLWgewJ11A3YU7XeX5oFwuluCumDIee0mj/jLpomng=;
        b=FfJ8OFVAuaXfY7zWqcQIpoy47WKr9ZN0aL/mp0c8kF7rpAbBbh5a0c5BI0bpJ6tlD7
         WjlsAvSi9YATRmBFowa+2jRSCN7pNP0Dg3ik/zBownIMPW7NgDM2OlQpB/N1CV4jiLy4
         MjJlvygUyrB1iUXQxjvNFCBHmL3K8EAGcaNVlUqPnp7x7IXAQm3auXOxo3ATaZVpZmUN
         Pl+1ajHrwx//Xwpf3Q9doSOlTfdt1f4SUOi6m2ap4qdkbAmtTsUuYHIlOP8off+pQo0z
         EUe6sp0MsJOTuYfAyl7z6TJuuHlsEDxAsdyIGg3cAusAZpMWnQEQTDwar5hCyYUhMnU+
         Jh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202893; x=1785807693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OWLWgewJ11A3YU7XeX5oFwuluCumDIee0mj/jLpomng=;
        b=mj3CmE3B9y097qpHN4Q737wFZ4ksFRUb5kRI7G8KQOYQkpCS+1PgLv5nPNyRXD8y4D
         hzZjJC9P0XIYSF9Z7oVAfDuMSgJPLQmu8Y8kEXG7OnieLaodA4GQq6YYoZup5I/eR2OK
         Y8cIO4AFusp3KWe6cmgL0xyxLDPjJPU4p7TDs2iomlRBv+4gsG2ZrZ2IOnfeqtDVE1Xk
         nCIVnaJqv1a4NQV57T0/vfGAlJr+x+ISUfe7EKnCFooCatZSnt2sQGdIOc7gerWzTgb6
         UfgkLxrFq/LVaYDR+4l0rWH/0A/vS+O0KTnN/AA+nnZ0MArJSRiLzxcd71TrlZJi/oM4
         Ibsg==
X-Gm-Message-State: AOJu0YyWUcHWf4usKtlAAQfjC/zJik4kqCBr2vujIDYiifnfVfsWiDSK
	UBSZCqqQPye4Z+DmK5lUnADNFJ50UXqqSXJKKEJxeFNxhTOnFJeF0cTfHK5mYg==
X-Gm-Gg: AR+sD1345fmv4Unk9UjewO2BGqrTgPSrPRfLcKeUNRWusbEyHVUjtuCqd6mUA+TXBUE
	x6wiwosv1omWEJ0CVAcBZ9Wy0ApG2e0XaP6mdO/cMFd60J2Hk3ltc0HxCwizMoazkv+c4L2G5xs
	vZYgftGrRk1bx9S54MrLejEGdiCOns0X6D8xQUkwlagGTDZ3t2nJG0bYA305bfk0ZmqcwVX6Gjf
	ml1sKe138isp/UXZvH3dG4aP7Elr9a8o6xnQRp3CBg8uQwu71TUBJ6hXRxJaWeyESp8URB4wys1
	VYe0P3FNaAt7DpU3o5OsTpPMW9uBi2kgAD3Ewuxw2gNSF5uxRcf695JPxSpgipqXOOtTzH86p6U
	+jWeH8gOTBsXmLxtPmsAdP5+qRvM8iOjOEzutNILHdkzFQhXzNiawVMZ9Q0yASmzliABCljneFv
	KM9wbhXBd7VtO1OR8tEykcYMjvuz0IlvS+NwkJajf+tojUFevQSHZaX5uKQcf7qWvcSeUHmkFdP
	v250hlf4stW/4TjutXf2ppceiGPEscKcfPDc6rhHE3EsfAxiXrmp/VXTd2gDTgMui6wtgQ=
X-Received: by 2002:a05:6a00:4f86:b0:848:5010:ad3a with SMTP id d2e1a72fcca58-84e933214f2mr322799b3a.58.1785202893181;
        Mon, 27 Jul 2026 18:41:33 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:31 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 07/12] containers-library: switch to multiarch
Date: Mon, 27 Jul 2026 18:40:40 -0700
Message-ID: <00eb5ec16719f386599c76fd78fa8613ea2be3f9.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4546

Utilize the oci-multiarch detection in run-push-containers script,
which uses 'skopeo-native copy' to 'push' the oci/ directory to the
container registries.

This does mean we are no longer exercising the single-arch path
in run-push-containers, but the previous commit is left in place
to show how that is done if we decide to re-enable it.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/config.json b/config.json
index 8c7a91a..d92c493 100644
--- a/config.json
+++ b/config.json
@@ -1912,39 +1912,39 @@
                 "_EXTRA_TAGS=\"$_PV_MAJOR $_PV_MAJOR_MINOR\""
             ],
             "step1" : {
-                "shortname" : "Build 'base' container",
-                "BBTARGETS" : "container-base",
-                "CONTAINER_IMAGE_MAP" : {"container-base": "base"},
+                "shortname" : "Build 'base' multiarch container",
+                "BBTARGETS" : "container-image-multiarch-container-base",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-container-base": "base"},
                 "CONTAINER_VERSION_RECIPE" : "base-files"
             },
             "step2" : {
-                "shortname" : "Build 'curl' container",
-                "BBTARGETS" : "app-container-curl",
-                "CONTAINER_IMAGE_MAP" : {"app-container-curl": "curl"},
+                "shortname" : "Build 'curl' multiarch container",
+                "BBTARGETS" : "container-image-multiarch-app-container-curl",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-curl": "curl"},
                 "CONTAINER_VERSION_RECIPE" : "curl"
             },
             "step3" : {
                 "shortname" : "Build 'python' container",
-                "BBTARGETS" : "app-container-python",
-                "CONTAINER_IMAGE_MAP" : {"app-container-python": "python"},
+                "BBTARGETS" : "container-image-multiarch-app-container-python",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-python": "python"},
                 "CONTAINER_VERSION_RECIPE" : "python3"
             },
             "step4" : {
                 "shortname" : "Build 'mosquitto' container",
-                "BBTARGETS" : "app-container-mosquitto",
-                "CONTAINER_IMAGE_MAP" : {"app-container-mosquitto": "mosquitto"},
+                "BBTARGETS" : "container-image-multiarch-app-container-mosquitto",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-mosquitto": "mosquitto"},
                 "CONTAINER_VERSION_RECIPE" : "mosquitto"
             },
             "step5" : {
                 "shortname" : "Build 'valkey' container",
-                "BBTARGETS" : "app-container-valkey",
-                "CONTAINER_IMAGE_MAP" : {"app-container-valkey": "valkey"},
+                "BBTARGETS" : "container-image-multiarch-app-container-valkey",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-valkey": "valkey"},
                 "CONTAINER_VERSION_RECIPE" : "valkey"
             },
             "step6" : {
                 "shortname" : "Build 'nginx' container",
-                "BBTARGETS" : "app-container-nginx",
-                "CONTAINER_IMAGE_MAP" : {"app-container-nginx": "nginx"},
+                "BBTARGETS" : "container-image-multiarch-app-container-nginx",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-nginx": "nginx"},
                 "CONTAINER_VERSION_RECIPE" : "nginx"
             }
         }
-- 
2.55.0


