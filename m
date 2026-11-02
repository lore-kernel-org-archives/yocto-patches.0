Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4370.1793659688799917431
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 14:48:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EmaFlTWk;
 spf=pass (domain: konsulko.com, ip: 209.85.128.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so18306545e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793659687; x=1794264487; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DGJ33Sv6mrFv0EKY2paYZsuyffqNuvLNLm0BK3iNdGA=;
        b=EmaFlTWkMm90ltiGayqzl8A+j+PSggtM0/CYQfJkfRPbLyAvomgcWiCSTVCpVHo+NE
         gu7oSPvDAweV0b00s9SYWLNTI1bBqDHeFmgfhdLwbvwldGtysUdshNKOGBlGO6mQR8q9
         Wt7x2NufXTj5vI8xyOGvOcwnK7MH1jQOs4T9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659687; x=1794264487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DGJ33Sv6mrFv0EKY2paYZsuyffqNuvLNLm0BK3iNdGA=;
        b=oy4UTVN8ZKu8Sjy85jArSxkcSlBRuFVLrqrlZmjgVJLX0Iz/VXR12WNDhl5M71qKqz
         3UbYml7BOGpFjD2yW+pSr+eePh4q5018xYoEcwIPHoPPcuSVl8wKxwl5wEmRu3SzdyvN
         vUtqRKXtjYHywMbB13w0Z6BT1GKhN1D/bIkGhlGTRrSc+trk6o0P2e4zooOrFjXDUtWk
         AzSLz8xdyo8660OrY1/q1Hh9kiQ64bgfI1vM+1ANBi6TackLdxVwspb1kmz9Dvfdp+vk
         GpiemPWGD/iUINJF4S80LK8CYEIfHYzqQ2DorCSj60tZvXHOpsofI3uJlvzhIwobirlj
         0uPw==
X-Gm-Message-State: AFq9FYI8leQyfqtriizRp+ElA4csXmLPJVJ3W9Xtor414S/n6buhcsd+
	byndKZrL7bu3SC8dyEthDszUdVlAWMTS0qariDcE3I5KCNgQyIDAHIhYMP+E4b88VCDe1fJuZ4O
	VprR3o0c=
X-Gm-Gg: AYBFou15krmTlqTEKSWAvCV6EakT+MOw8cCMDCe5jYTi7w35x2KJyKdW8YVxwsh01bv
	nCaSdBvE2gqmMpJSrfWXlle3Xt+7q1xma/IGm06B0co6r32dNFNMDRkt33dxjjCaWDj+f1NDT+e
	SIfev78LRJq6Lt03deza/I1REqd3x/wxoN4k9ZB97tCuSlEcK+mhAO+YsspZIKwybe7V92vmk+P
	qzScA9qz5oJ9NQH0OG+/4I8QGR/GHr6jIx0uKcPlVYaRh2taAfXOE3oAODZCZqiKIwrFg4f3CHM
	M3gUuFSQZCJvCxXD9uwRg+0AsJ/5BPU4qjzULteZAjWhATlVrrSLb8M7ZoxisLK+xw9gxTni7it
	/Njco88o3n5CAd4TLZ1Ot88nNwOo5oMOVCyqCab+ZXc83DxXmtWS2M7lKD01yQ8PCqr8i+J2t11
	jlo+dJWQiragsHRa1vqaLPbNhlEFmfNnxYT+C1afSCFEqBD7wE/XWbiQmV9lbQbebza0EuhHcZH
	pU4Ki9JEDRnr4/OegI43TgOnWPTI7yp/PbdjCcbj9/LwB6MLzyBDWlBufTp+tbqJs0QxlvQgoU+
	uf3wGuYAWL2hlL7XmP5fOw3RHwBDL3ESzPY8KpYEn7eSObprMAgDT8VQ5k1lp8pwjUwCM0Pn628
	LG2G+15EkBVis7Zeojo4L8EqSsaHfFQ==
X-Received: by 2002:a05:600c:3f0f:b0:4a2:1612:636e with SMTP id 5b1f17b1804b1-4ac16bc4645mr263818305e9.5.1793659687038;
        Mon, 02 Nov 2026 14:48:07 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm23770828f8f.55.2026.11.02.14.48.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:48:05 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/4] swtpm: Add missing useradd inherit
Date: Tue,  3 Nov 2026 00:47:46 +0200
Message-ID: <9d9461f7fa7da22f654a1c368e31a21db537266b.1793659376.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793659376.git.scott.murray@konsulko.com>
References: <cover.1793659376.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 22:48:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5210
Content-Type: text/plain; charset="utf-8"

The swtpm recipe has USERADD and GROUPADD definitions, but has never
inherited the useradd bbclass, fix that.

Reported-by: Ehsan Emami <ehsan@emami.net>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index 8472f02..8488d01 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -12,7 +12,7 @@ SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=h
 PE = "2"
 
 PARALLEL_MAKE = ""
-inherit autotools pkgconfig perlnative
+inherit autotools pkgconfig perlnative useradd
 
 TSS_USER = "tss"
 TSS_GROUP = "tss"
-- 
2.47.3

