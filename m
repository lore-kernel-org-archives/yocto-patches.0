Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CC4C5AE5D
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 10:56:35 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27103.1786359389880382486
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Aug 2026 03:56:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ex6Jvtk3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1049468f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Aug 2026 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786359388; x=1786964188; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwLcUOP9smHMXVtFjQBQ4VsN8/nNRZQ9X3bgjoWkwq8=;
        b=Ex6Jvtk3qyb8leumI34FNuxmB3BhJ/XaZFUzLjkFoadXzZ8716w2q28Y7IPw7/jZ+Q
         KgruYVe2m7WCiCw3Zzs9aUlR5ND835QZ4CeXag7zLR7UuY3/jxJuoFyhoUTGF+MEEvQf
         /8UHb8ZZLMKqOrAXLSPE5PEXLCUugUfciab9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786359388; x=1786964188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CwLcUOP9smHMXVtFjQBQ4VsN8/nNRZQ9X3bgjoWkwq8=;
        b=Lvoa+fGmorFb7cimDu4GtvfRuvAFxHbn8uGNOG0S7FJ6m1Pd8+TjRMZ5SP5V3Cl+Pw
         UOMCu7G0JYo/l+BOy21ic0vk1jl6gSrKWHYNDpXQd/hzTbkQoB5pQwpHFxGxD8EvDiB5
         1ko9RdrDpLh4N20gjJM/G/Elns8a4lckjwZh0eyjgfKbO0g9ekEWi4ea9QYJW6ELbItm
         PMqfOnuMKn5aYrdkVFLOFJq/7TdiQRG+sIBHxRbVn4SSvzIBoWA5BvHSu67DmMZqkf2b
         Fi8btBdvLxx/t7GApMvptDiBKkzCqTeNi/yo9eSs3DQU8FOue9kCRrY7R0BgwQvfAQFr
         SbZQ==
X-Gm-Message-State: AOJu0Yz7CauPGAWT+J6hMMBF8dh0bLPiEgtG/vjzLHal/5MKfNESRC0/
	ItsGs6dgmV/d4J9198ASMAOXVbLADL+JnBNLzJmQe+frmlHlc3qDwNr3gH/Nmnom6+awDVcwBCe
	HFUUiKpk=
X-Gm-Gg: AR+sD139aic2f3a4lpVzru/dzXABvdsz19YmNMaqGn+i48MoJBcgBpxUCa10de2ynvP
	mUn47Mgk6dpbunXfKUIk8KnlgibZr8fNBdClQMokSJQpczcXgsel2p/QTKiP0F1ZRYtC7+L0/fy
	zMh6jr6VtwOt5LE5NUpaH3I+GG4SK2syY4aS0Z7aEFM99/zGk4TEHX1pHmQ6CZSynPZKR5rUo60
	AI+7CHsxNC4bn2BaBv4NpEt74F2Wuee8gWzJ1UGmU2Vzr8hpuEasyzBXOBT1sWtONmf82oo5yQV
	mJ1TRQVVTsx513GiO89PrdhgxOFnhf7uNZIJCqvunNBCAppBZzoG2v5hlk6SsEIWNSl4xy4RWfL
	vmwlgvG38xaSUbVBpu1CuX+BnGPKz4GkmDQ/Y2AX7yfC7LckE6WUyPc0X8ktbVol8JSR2EhqQoH
	6YV6vOmDm9G80bxEE/OXys3ZihARFY+u/nYn+guQXqE8EsElfj0yfoeRypaLkzc2tU/sY9iEj6m
	zRwKJRwtDz2Y44bwA==
X-Received: by 2002:a05:600c:1d24:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4995e08452bmr285922025e9.5.1786359387252;
        Mon, 10 Aug 2026 03:56:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:96ae:4423:ae88:ca02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542851d6sm450502705e9.12.2026.08.10.03.56.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:56:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Disable meta-qcom for now
Date: Mon, 10 Aug 2026 11:56:24 +0100
Message-ID: <20260810105624.2601121-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Aug 2026 10:56:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4655

This has been failing for a while now (3 weeks), disable it until it gets fixed
and we can add it back.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index f9fdca8..9fd9ba3 100644
--- a/config.json
+++ b/config.json
@@ -651,7 +651,7 @@
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-weston:do_testimage"
             }
         },
-        "meta-qcom" : {
+        "_meta-qcom" : {
             "NEEDREPOS" : ["bitbake", "meta-qcom"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-qcom"

