Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0216CC282E3
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:22 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.10380.1741170319144320678
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P1oZZjmy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so2450345e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170317; x=1741775117; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoaxDWaC2U1gpYDd4yPoakWqQy2zvlKmplBy2bzBI0g=;
        b=P1oZZjmyr0UB9bb7qj2YyjHk9Nj01T1QgVQsZnJ228XlfHuQ8HtQmXvudM3FINdb0X
         cJ9KMkqzutAU5ueALmDZ1ssIfsBFNLrjYNSWqrc2AJGpjtQ7ZVEAnTW2Wi6dFXx+yiUI
         R/tGm92rrs9mmhmthj/2WEZxkeez6fbV7+5og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170317; x=1741775117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoaxDWaC2U1gpYDd4yPoakWqQy2zvlKmplBy2bzBI0g=;
        b=ucguLPnprRLt+xDagaQAIybFpgN0Nk5HICug70iN8+ZYe1852IxsSt/dncp17RmrSA
         GLV6BJbG2wVNPERNWhDpnP6F4Gnxs4Nivq6dOHyTE8+dE5ONr5CzexJzi5Rsqa+XwZgs
         Psx6LloPduZRg9IEArbFZCQF5orlQu24tfkF7OV7h6M2S5cE6RiH/fQ7UQ6bM3ZZ9S7E
         +ElGggKAZEkvEsxW140SqorTNk1lf1ZOw1PYLDdEe/87Yu2wN3X7CQyZsHjmtK9BiyF8
         3hPXp0Me4bcOxxymGl74qMvSE12qg68pjPKOJ6tnfusejZUF1gnMT3baPw4e2L6JXQjc
         TYOw==
X-Gm-Message-State: AOJu0YytuqjeJEJg9W5KyCtbIu6CJcpO25WVAjnultBLprf/19KvJ6tW
	JBlxnO2qUgxCcpmqsr5NPu9h0PAb5+1roy2xjT8D+MD1IQWwnCJeZ0R4+IwhdH5uNemLhaGbBw2
	l
X-Gm-Gg: ASbGnctJMRvGdIefiILpqqnM3EXn7nQvsFBFs3boLEHaQX2i84kY6tjcjV7+WRA/PRf
	5TtDrpkFiUUdYscDaOvAraEmOqFfYXcXA/2mjZYir6GXX7j4YkYn2m1H8IXFayEuNkuquvw05HV
	ZcQhnjVTMBTF+kUCgH8kdkguKf2oensEAK8A/j6fWOd9SDogcNi2q78tmErOo2qvDIw2fGFYbXC
	Rf3r04DbRbR076RIeH5YeJ6hbbFsZfJUk4a1TMM6OayVnRtoR7ENzO7omf80130D090D1VGgkXI
	UBrnQqPTymhncWfj1VWSi0qQx/drjIrji0hG8r3X96B6j66bOFLNWc9CLfc+6+FzfJbi0stRhQ=
	=
X-Google-Smtp-Source: AGHT+IEltNCLoPxK47RCVsWJRgnhbx/K/ABNf49TvXwu9nvzTu23I6kBAdIV0DZGxuXOzbufyxS/gg==
X-Received: by 2002:a05:600c:54c2:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43bcb04ef6fmr60465815e9.13.1741170316732;
        Wed, 05 Mar 2025 02:25:16 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:15 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 08/11] setup-config: Add support for removevars
Date: Wed,  5 Mar 2025 10:25:03 +0000
Message-ID: <20250305102506.2043524-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1152

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/setup-config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/setup-config b/scripts/setup-config
index 76f4639..594ff5e 100755
--- a/scripts/setup-config
+++ b/scripts/setup-config
@@ -96,6 +96,13 @@ extravars = utils.getconfiglistfilter("extravars", ourconfig, args.target, stepn
 if extravars:
     variables.extend(extravars)
 
+removevars = utils.getconfiglistfilter("removevars", ourconfig, args.target, stepnum)
+if removevars:
+    for var in variables[:]:
+        for remove in removevars:
+            if remove in var:
+                variables.remove(var)
+
 bh_path, remoterepo, remotebranch, baseremotebranch = utils.getbuildhistoryconfig(ourconfig, args.builddir, args.target, args.reponame, args.branchname, stepnum)
 if bh_path:
     variables.append('INHERIT += "buildhistory"')

