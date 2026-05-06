Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC88CD3439
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:35:03 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23201.1778085296049803447
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:34:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MC1+QE0P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4526a8170ceso235062f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778085294; x=1778690094; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ixgACinzgavE7jad8eIYl8B1Hif0JoJnzWVrcIw8I=;
        b=MC1+QE0PPr//lReZ/71lfNPcYoggvK1NVDFYuwvCt+EwK8eQwAFFCouUel4imHaqFT
         th/apLQMRHhXNi5OHgXuvrqs2KkbU+A0YqaGoFxK+Kwv+O288zLwsSx4LB3RIV1E02nh
         DmDLnKd3CXPXQmBfDCVfyudl9J+GngXh6wGv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778085294; x=1778690094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/ixgACinzgavE7jad8eIYl8B1Hif0JoJnzWVrcIw8I=;
        b=MobEdza1S8qBWFBcN/dN/hLrM4TvLTChz3jMdycMGDH5U6RK5AUkVZBcQS52SmHSDw
         sS38Xw4RcGnuagrVBgpuCNvtSrXg8LSC763oEdY8aUqN4Kfyy9ZkLXGON0fplbTcrFKY
         1SAM9xtCE9RHnWwCKMfimoF6pPybut9wugUsb51i8aKsP++KCa9nD9MLVk7TBXwg+jmC
         HGZeAiJ83nOZVio9zvEKWCE+ovkWabqsFaj6e+Gai1zHACFYMkoLwtsUSMuGe6k04mE9
         7r9BRNiZQMbSnDIgVtr2DUTf5AqvHTfHYrNe8+YzYxIysfhL0kzk56ZAWY/OSQOPhVnO
         5H+Q==
X-Gm-Message-State: AOJu0Yz1OpX9oaw4ETLy49HRp4qe9E8fb8zG0LAUwcq3XhBil07lX0tV
	y8mFkGPzwRNAMY4FYYKEdV91N+v+Tmot67/jm269hGP4zISEEP/JeLdw06Msoebz2YxZzkB8GpH
	QHAN+
X-Gm-Gg: AeBDieui/KIGabXULoZe1643gfo+aUwNrWrE83TG7GOrbcZE1xrEaPpmmo4CRvUjpqQ
	1Am3dlyYrOucFXkSh8pyskx6ExxBLAmBUomoVqckm1W7dnFVzgMY40fUVBcMzxfeFhyJc4xpiAc
	HyoPHAZiFiMUPsitdtPZAj8T8cG/mrPgPTN85eTgO3RYBIsOR7Oqj2dQWcmmdde3537/Rtnlq1e
	p/FoQvbOf89WN6o8ozLhLyyFkdIRs7RTZUnrglwXnQzKcVeAzPYgldqQJeQ41+6qeJXgoV4HMrC
	Qc+ah3rTM1DItPZ30jSnpOBJGZlV+d7A+DZKWc7nI27+06oQqEb29IwSkAcRQhuUhaZn2ArQzK6
	VRinmWYP3GcJZGq+kJg6ZbSMhHQtBGGnSKiTfYp5ydxJ3mu7XaCZ7N6NavZTL6Gvn+tMBmP6xxC
	tE9Ui4hr7Y+QW2/+adW89fFzFHVm4Bl4Dp6Y3RCtt4/sJDEwoenwm9xXKKy5k8EXI=
X-Received: by 2002:a5d:6950:0:b0:451:6770:575c with SMTP id ffacd0b85a97d-4516770577fmr4539352f8f.0.1778085293492;
        Wed, 06 May 2026 09:34:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm14363629f8f.31.2026.05.06.09.34.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:34:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/2] publish-artefacts: Handle aarch64 toolchains
Date: Wed,  6 May 2026 17:34:51 +0100
Message-ID: <20260506163452.2086-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:35:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3928

The current toolchain publishing should be updated to include aarch64.
Also drop the obsolete mips/ppc targets.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index 10adde5..b024c09 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -22,12 +22,12 @@ sha256sums(){
 TMPDIR=$WORKDIR/tmp
 
 case "$target" in
-    "qemuarm"|"qemuarm64"|"qemumips64"|"qemumips"|"qemuppc"|"qemux86"|"qemux86-64"|"genericx86"|"genericx86-64"|"beaglebone")
-        mkdir -p $DEST/toolchain/i686
-        mkdir -p $DEST/toolchain/x86_64
+    "qemuarm"|"qemuarm64"|"qemux86"|"qemux86-64"|"genericx86"|"genericx86-64"|"beaglebone")
         sha256sums $TMPDIR/deploy/sdk
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*i686-core-image*-toolchain-[0-9]* $DEST/toolchain/i686
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*x86_64-core-image*-toolchain-[0-9]* $DEST/toolchain/x86_64
+        for arch in i686 x86_64 aarch64; do
+            mkdir -p $DEST/toolchain/$arch
+            cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*$arch-core-image*-toolchain-[0-9]* $DEST/toolchain/$arch
+	done
         ;;
 esac
 

