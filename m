Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21289CFD64B
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 15:00:36 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7739.1767798026671498971
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 07:00:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SYhFB2t5;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ffa95fc5f1so18274211cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767798025; x=1768402825; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AILFoeLGr24Aoxs0+eHtfgPNJztQiHQD1/vUuQpDkaM=;
        b=SYhFB2t5fKeJEV4PmyW2eefCSvurOxxv2/cmB/0rypvzVzWKbkgKZpw1wS5KCV4QI3
         4/RZunl5wZwl2CIgLiL2SMtGQ8N0TnrgdvSagxw+i8xlXWHtFZWWg5NvVXpTYqs5fuY3
         cHJkDjMdeBcnEi6tHNGBvb1U8vWzUNxyiP5/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798025; x=1768402825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AILFoeLGr24Aoxs0+eHtfgPNJztQiHQD1/vUuQpDkaM=;
        b=tdKJNg19lpEsdQAfROOqVREYBpJfO9qz67djnIH4R8VpeUZHOXdO3Vj1AJRSPOilNN
         v92/f4OQsIh5TswCPh6mM79bIHTpbfuBgnptAOU4/GCGdXhMbLZaSP9fohD/6jlVOlRi
         sOII6c5Mw+KgoxKaYZYc51REf2OY7LlrkottYBVD4nsgaKOm2BcJEGTGViP7Ne2bYw00
         4t7B46VSH8xaeJTtn5SPyOCQD214DbhvTOuLAykrbhk0j/IJhBTdmHJAhO8L+OrvE8d6
         zGeSI2ZzzuH0k7hYyaNFWCKGqEpo/AgPjHmtKLLlHkAR02NGb6WT6tNPvudLxILe5wQ8
         zYwg==
X-Gm-Message-State: AOJu0Yw31Sr+91nTjSi80rqj8Uo76SvNETUytGM+lmwI8uTmsAO81elD
	YX02Lf+XgFbaWSp0sFtLS4cKNNNhaqXtZMrFq/cTFASaGt56KJ+iBQoar5yn/NLH5zd7ZExNZro
	IldFK
X-Gm-Gg: AY/fxX49PY4N0hElzW6qUFTkVT/hyk+6rjb2L7SccuI5Vi01ZWSm48Y5zsyBd1f3KP+
	tDvgsJFvg3y3WWEYD9OqD2uAQkYjBmF9jlydGlZRW5B0nJvTtTN+EjJcJmbL0/I/HCEVI+xTV8P
	eTRkfFHVX+Q7TlHy4k/5wzxavPAqUdKIQaVe3zfLQKvIZFouptdxihztZJIXodJ0JxNKh9NrsCT
	TgmQDIyr9G2DJ/RDqjnNDozkKYArPcxXxyh1tMOZG7H4cORRvmJCMl3cKqN/Gsqy/j18LYNob8W
	sUjzHyq3R14RnaTHMA4dxO0hKj5cjGf+zKxHY9gmCQMr/gRY6+rf3SJ5yfrlyPym6EKNSHrlQyI
	6AXLeMKC+TBYzrxHLHQc3cWhUGhy98jYxbgtGAvoelzjPlA8pyHX11/wzSuWEHx+avIwY/+PW5J
	nXBsxvJGLvG3J2n1wCy58La1DbL/yP+OueTm+HVnLConYXreMxiIC80OVjTPmM9IFVKr5Ff6Fu/
	O3t4QS8Yfa7MAN97US+uDRb/BRxR8ZrJvKhy8Q/CF6qmBwqMbO6jhtoPz0MSLA=
X-Google-Smtp-Source: AGHT+IEgSlLBBOwqUC1jV3bjP3eo1gZpcF+Q9te4uLm6f3CUXRBpY57GbW4hB73b7PRXBSP6okirJw==
X-Received: by 2002:a05:622a:20a:b0:4ff:8da6:2289 with SMTP id d75a77b69052e-4ffb48a8a61mr31427481cf.27.1767798024767;
        Wed, 07 Jan 2026 07:00:24 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d568cbsm34113551cf.11.2026.01.07.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:00:23 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][PATCH 1/4] suricata: drop trailing whitespace
Date: Wed,  7 Jan 2026 10:00:06 -0500
Message-ID: <2fc3c2748b2edafcab27dc38e988f60aaa2991d6.1767797568.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767797568.git.scott.murray@konsulko.com>
References: <cover.1767797568.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 15:00:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2908

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.13.bb | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index 0635bf3..7298f1b 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -40,18 +40,18 @@ B = "${S}"
 PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net"
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
-PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ," 
+PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ,"
 PACKAGECONFIG[yaml] = "--with-libyaml-includes=${STAGING_INCDIR} --with-libyaml-libraries=${STAGING_LIBDIR}, ,libyaml ,"
-PACKAGECONFIG[pcap] = "--with-libpcap-includes=${STAGING_INCDIR} --with-libpcap-libraries=${STAGING_LIBDIR}, ,libpcap" 
+PACKAGECONFIG[pcap] = "--with-libpcap-includes=${STAGING_INCDIR} --with-libpcap-libraries=${STAGING_LIBDIR}, ,libpcap"
 PACKAGECONFIG[cap-ng] = "--with-libcap_ng-includes=${STAGING_INCDIR} --with-libcap_ng-libraries=${STAGING_LIBDIR}, ,libcap-ng , "
-PACKAGECONFIG[net] = "--with-libnet-includes=${STAGING_INCDIR} --with-libnet-libraries=${STAGING_LIBDIR}, , libnet," 
+PACKAGECONFIG[net] = "--with-libnet-includes=${STAGING_INCDIR} --with-libnet-libraries=${STAGING_LIBDIR}, , libnet,"
 PACKAGECONFIG[nfnetlink] = "--with-libnfnetlink-includes=${STAGING_INCDIR} --with-libnfnetlink-libraries=${STAGING_LIBDIR}, ,libnfnetlink ,"
 PACKAGECONFIG[nfq] = "--enable-nfqueue, --disable-nfqueue,libnetfilter-queue,"
 
 PACKAGECONFIG[jansson] = "--with-libjansson-includes=${STAGING_INCDIR} --with-libjansson-libraries=${STAGING_LIBDIR},,jansson, jansson"
 PACKAGECONFIG[file] = ",,file, file"
-PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core" 
-PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests," 
+PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core"
+PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests,"
 
 export logdir = "${localstatedir}/log"
 
@@ -81,7 +81,7 @@ oe_cargo_build () {
 }
 
 do_compile () {
-    # we do this to bypass the make provided by this pkg 
+    # we do this to bypass the make provided by this pkg
     # patches Makefile to skip the subdir
     cargo_do_compile
 
-- 
2.51.0


