Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4193C27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:33:11 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.21164.1718029983100795562
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=VxVtEj4H;
 spf=pass (domain: snapchat.com, ip: 209.85.218.52, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6efacd25ecso136574466b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029981; x=1718634781; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELOmBXtXjW4C3YUEqjmYWVSgD5UBhbom+m6oEBG5R80=;
        b=VxVtEj4HHo8i1fmXnhW3qsa2gu3ou2CfgEEe1Wbi7wVynRPrh9lCl9ZDvQi8wlNBzK
         euVJN3lFLfsZPGQFQVXPWH5fuUIajCHD5jkj473qRwIXsW2ugwABNylgn3YSw/ctELMC
         9Srwx/Nwght4BytzAA0tFTAL+9b1j+2vvx76Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029981; x=1718634781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELOmBXtXjW4C3YUEqjmYWVSgD5UBhbom+m6oEBG5R80=;
        b=TuY7PZXZSn5vWp4WDBosssfl9/vepHm9bNwmAL4tld7MPZy35yjAIVlxD8yxP+ep3K
         FrsVph2O5vYPbvwJo8KoS9ibqPJEvoweEgtJBFmAt1cZyBPWKkCXQIOQZbO76qsWbudA
         aBrKiR4iwUWa962zzch8wNmYf0xcJM4XsQgXOFHdMSd4tFm4fSZPo4mA97UdPz8wF1+C
         g008VgQd8lEdsAyxziW+ilrtG5Dma/w5VdgjP9clODszWeFVdE5xBOOk3IXSPuogPnLM
         UurOuELqPs9bn4f45Mym9XtNkubQyq7sVVCEEB7ntLvkFrpzGKShCXU7pOTexHRIbXQl
         wTyQ==
X-Gm-Message-State: AOJu0YyXfivxx5FWFQdY3Gxx5JGatowpnsWBxTPGH+c33eWSAj0X6d66
	7MOhxnPRJohIOrfJfICjHDIhD3GduBShK/rwWP9ymCyiIwxbna58hQN36lq2jpymrofSJwcIXxP
	jMkg=
X-Google-Smtp-Source: AGHT+IEE4aG472HUEScisegRM4Mr5+Yujf+g5g9mEmy97El4nbbp7Sy8F3DZwqHybizHbCS8peMH1g==
X-Received: by 2002:a50:d483:0:b0:57c:77a1:d1da with SMTP id 4fb4d7f45d1cf-57c77a1d257mr2917281a12.0.1718029980848;
        Mon, 10 Jun 2024 07:33:00 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:33:00 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 09/11] gettext: fix scarthgap build error
Date: Mon, 10 Jun 2024 16:32:12 +0200
Message-Id: <20240610143214.2376414-9-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:33:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/291

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-core/gettext/gettext_%.bbappend | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 recipes-core/gettext/gettext_%.bbappend

diff --git a/recipes-core/gettext/gettext_%.bbappend b/recipes-core/gettext/gettext_%.bbappend
new file mode 100644
index 0000000..d3314d0
--- /dev/null
+++ b/recipes-core/gettext/gettext_%.bbappend
@@ -0,0 +1,5 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+
+PACKAGES += "gettext-alias"
+# For some unknown reason this file isn't packaged while building nativesdk-gettext
+FILES:gettext-alias = "${datadir}/locale/locale.alias"
-- 
2.36.1.vfs.0.0


