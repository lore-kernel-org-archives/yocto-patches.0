Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA960CA5FC7
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:59:07 +0000 (UTC)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17150.1790783940563530702
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Sep 2026 08:59:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cIPyLPug;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.98, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so560972f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790783939; x=1791388739; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zwDRTC++iFUTm6RZm9KnTjUJd2AsO0twKs49ofFix7Q=;
        b=cIPyLPugLgfB0pWhJDm05asF4Y8vFqdN+hJMhABfaH4wsaJaF06ZX0I6p03vZweucB
         LS6oP4FrCCmGTVJFN9vAKFSNmqxNWt5yH7+SoKpY1IiWbCIuQIGVCwrhmb9UfzI4jZUE
         6bed3YaHvrv1KOJdeUi0sW0aWFuy8k9vVQa3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783939; x=1791388739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zwDRTC++iFUTm6RZm9KnTjUJd2AsO0twKs49ofFix7Q=;
        b=unSuJGQVtR4kGH/KysZ1ikqUDNZwYM1kHdwMkZdVH01v+QHU+LhqD2JJsTrZauc0am
         DFsJf/leMgljS8cm+ZyQ8LsjViOVmldMwRD2EOiShx+ef3Es6F9Lf8IyDRb4pLat+YR7
         HHMsh7g+k4cuh1o5OH4VzpxJ0M9KztOquAAsKLFQDs587HCc0r9UJ4M4oqmTSSmzmaNV
         LT4O6bVdm2AH0nM82Ssm4IfSi6eW8yOzDdMPZ5jJsdufWwp8MTC1mYgJcJguXh/FHETF
         tItmty1NdqMq6TsSZxIalR7rbZ6up1IESULgd3jUZ6pFGtr0JjgWGsAHUUNc7CvgnzdW
         CSxQ==
X-Gm-Message-State: AFq9FYLTadTHnlqTlSR9TmYyeCemIWYitpVN9YntmgUnBi3iYLHwMApf
	jj9bPQVEaWyfF7MkJr0iyeG5RgLQL/WBBZnQX0itkN5ypcRxdpe+z6v1rj20ZoL14mm+3USqYe4
	XoAoCpPY=
X-Gm-Gg: AYBFou1QdPkvw+okClI2IcPpLtArtfcgGqc3UMY4mCYDnP7tjt+z31oPJXvi5CR56qP
	I8cycmQF/BcApU2oh1eT4LfFC5kuOgvewxMilA5PBq14I36Iko40ViKidxl+m/GGZ/8T+dbLm1u
	XnSvlmtG1cY4u+m5+OKXK+Y7xCAV3hPvJ3xLkKjv9wjjj43i3qNUXTFS+f4cFlXbgagn/JWCKTo
	Hpjjtxh0L+6HZFXpTezEaCypyJdF25OX6GzQZJV4e1dsuZWxbMqjOsUKsFhhc/oFuW1uXqv2hns
	GCQXsZT6zzp4Ley+LjbCLFdD4Be3tvt0tolW5pd0i373DhIVqedNy8HW3b33nT+fxpRJeBf+nyN
	92kQOAXlvOD0+lYuPu0rJnKdG4zSgcDTSVQLlFwVEU96HOfvszkC45DrVw6rjpaZIkHVIrTO5Wb
	2gE58QfjNCm/ir/1xZlLjQPLL18yEvJe6/GnCyvN+3Mvr26vqtaMGCiPEXvOOArsnVQf3CuMMWb
	rJX5hppG3jqYemzAdAA797EbQ==
X-Received: by 2002:a05:6000:647:b0:48b:14e:fe04 with SMTP id ffacd0b85a97d-48b049b2ad5mr1503268f8f.6.1790783938705;
        Wed, 30 Sep 2026 08:58:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:349:f135:e106:4c82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02a0462bsm4490925f8f.33.2026.09.30.08.58.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:58:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/2] config.py: Drop meta-gplv2 from main targets, no longer supposed in any release
Date: Wed, 30 Sep 2026 16:58:56 +0100
Message-ID: <20260930155856.1179553-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930155856.1179553-1-richard.purdie@linuxfoundation.org>
References: <20260930155856.1179553-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 15:59:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4973

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.py b/config.py
index 3275e6fb..3a36e723 100644
--- a/config.py
+++ b/config.py
@@ -7,8 +7,8 @@ baserepos = ["bitbake", "oecore", "meta-yocto", "yocto-docs", "poky"]
 # ## Build configuration, tied to config.json in yocto-autobuilder-helpers
 # Repositories used by each builder
 buildertorepos = {
-    "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
-    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-qcom", "mixin-wrynose-linux-firmware"],
+    "a-quick": baserepos + ["meta-intel", "meta-mingw"],
+    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-qcom", "mixin-wrynose-linux-firmware"],
     "non-gpl3": baserepos + ["meta-gplv2"],
     "meta-mingw": baserepos + ["meta-mingw"],
     "meta-oe": baserepos + ["meta-openembedded"],
@@ -23,7 +23,7 @@ buildertorepos = {
     "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": baserepos,
-    "check-layer": baserepos + ["meta-mingw", "meta-gplv2"],
+    "check-layer": baserepos + ["meta-mingw"],
     "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "mixin-wrynose-linux-firmware", "meta-mingw"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
     "reproducible-meta-oe": baserepos + ["meta-openembedded"],

