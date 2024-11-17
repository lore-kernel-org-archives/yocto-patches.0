Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B47D10F2F
	for <webhook@archiver.kernel.org>; Sun, 17 Nov 2024 20:42:02 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.25500.1731876112461888286
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Nov 2024 12:41:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Rc4Ixo1L;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38231f84d8fso104944f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731876110; x=1732480910; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEjUfsBPIgMkPgDscGQAK818baNjjPn9Hv5LPnuyKNE=;
        b=Rc4Ixo1LdPr91MeeUik7b0arbCevRcmNORZrvGVLVZmQrL9IKhwvc3k6fMQGHm4D1+
         KQStRIAxOWJSx6Nh25srq6Yye4kLR0ijoPEANdVchvITNHuj+G4Jh+zdEo93NW8RCxjR
         X+WwRKb+ysgDmvA+QzJftL/UPjkonFQprhss8WRVWuWV3pWTsws9WugzeBRg8y0mnbud
         bvWMcu2aJJK1aEl5seUouKjaAiY8DesfdaT5aj1DwAvFfYZrnkDkF/nt1OgKDDzMZvzY
         G0s/eBZN1IeeMjWEFl29TcRWBvmdCrt38T1UOZquujgf8rSXJI2GVf+cbYuFCNxdY9Eh
         sKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731876110; x=1732480910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEjUfsBPIgMkPgDscGQAK818baNjjPn9Hv5LPnuyKNE=;
        b=cIk3bgcSmPHFkx60mPuIAclDm+Wt36/FBOvbs7yj/gcgapSj+bhtGrkjc9Hd4VJHgO
         L71wmsgqq7sOIo7DTZ21iNHugmi7CgVoq9UE97gyNmYyP1xsRi4AXF5xFfU7rMGwTKk7
         xVSHhzA9+aobtYb/0nFGm/TwnxJ8dZzn5SmCutTHKO0Zx1Yan/ZLRUfORAYVIVra9Wdi
         Yp/jygmwC82ZqEyEPaWK0Gd640zpUx+BwUw/2RASoNsQEUTMBEv7gdbfg0PakyMn5U70
         TpjunCYGU2AbVqg4CVBNwJMEmT9+XsL6FVkXLrNAHMnijJNpn/fbbGNUcBdHgcH5I6xl
         IfcA==
X-Gm-Message-State: AOJu0YwSa82kgIBkW1nlFmooMK7PNFlCroGHQnyNpcl5m0/FllTkuGVZ
	Ery/Rx9+psuk/Hb4j+YZiAON24w64rz4pRTnI6qMKkeAstRqp/8OCi5yvMOy
X-Gm-Gg: ASbGncte8Wwk2PmwZwEZhgw/04ifqa8+VzQI4RFOXTm13cIQM7uSpwXpf5iDgaeIEPu
	q5ITyvbrTx1VYaS/0IYMglFiRiVJMyftKSz+d0jc3K2moMjdKoOVd716dL7PKQ5VPX6GgM+aezw
	iI5TnOjBtEf6dDNddfWb4k+W077g1GzF9bKuUXzWEjvXraDt529Xy22B31OW3bTNvvrD/HyacQV
	pdXRD5yn6cHqJnfNQBuzYxq2bhkII3tRlcRXxFqsorVMJfP0kSh8sezgquP
X-Google-Smtp-Source: AGHT+IFVNeOTkti+WUYihj9MApVUETYdf/AaJSxTL6dqsuWk+WGOLYYukvY4lOkh+QedDtTqdEj6Rg==
X-Received: by 2002:a05:600c:3588:b0:42c:ba61:d20b with SMTP id 5b1f17b1804b1-432df728caamr35268875e9.3.1731876109980;
        Sun, 17 Nov 2024 12:41:49 -0800 (PST)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2658a8sm136607955e9.9.2024.11.17.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 12:41:48 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Thibaud Dufour <thibaudd@rtone.fr>,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [poky] [kirkstone] [BACKPORT 3/3] sstate: Remove unneeded code from setscene_depvalid() related to useradd
Date: Sun, 17 Nov 2024 21:41:18 +0100
Message-ID: <20241117204118.3405309-4-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
References: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 20:42:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/814

From: Richard Purdie <richard.purdie@linuxfoundation.org>

With recent changes to runqueue in bitbake, this horrible hack is no longer needed
and we can drop it.

(From OE-Core rev: f7f50b6013f7b636fe46448b1cbe1473de891527)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Thibaud Dufour <thibaudd@rtone.fr>
Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 meta/classes/sstate.bbclass | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 91d42665c1..b05766ce4f 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -1123,11 +1123,6 @@ def setscene_depvalid(task, taskdependees, notneeded, d, log=None):
         if isNativeCross(taskdependees[dep][0]) and taskdependees[dep][1] in ['do_package_write_deb', 'do_package_write_ipk', 'do_package_write_rpm', 'do_packagedata', 'do_package', 'do_package_qa']:
             continue
 
-        # This is due to the [depends] in useradd.bbclass complicating matters
-        # The logic *is* reversed here due to the way hard setscene dependencies are injected
-        if (taskdependees[task][1] == 'do_package' or taskdependees[task][1] == 'do_populate_sysroot') and taskdependees[dep][0].endswith(('shadow-native', 'shadow-sysroot', 'base-passwd', 'pseudo-native')) and taskdependees[dep][1] == 'do_populate_sysroot':
-            continue
-
         # Consider sysroot depending on sysroot tasks
         if taskdependees[task][1] == 'do_populate_sysroot' and taskdependees[dep][1] == 'do_populate_sysroot':
             # Allow excluding certain recursive dependencies. If a recipe needs it should add a
-- 
2.47.0


