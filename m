Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F8C44506
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 20:53:01 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.961.1783630372195023633
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 13:52:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QcPEev9o;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e85499ffbso16157585a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630371; x=1784235171; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IyTe0muG2yLwepIh9MwU4EFl2Y0p6e17Fb/7mFLehhg=;
        b=QcPEev9owTveffqL7eaWxCa2ReHpSFtFrNGfLLD8bj9upcDPhhGwoDvRdT248ZdmKn
         MgbZ9Uw5FiOVD5CzXq+2NMBjpVAeATa3kcgN0/Jd4VvCMT6GO+xLrO+S0i0iM8gwZ93s
         fvOjg+SSvxp9Di99H502vrurpxCefL9jNo1f3QSYfvrl3YTY4KkVhQNe6z8lIJroMVNE
         qzks5lRmDT9v9xY/jga0rBlP4f9Wp99YVYnMPG/prbh37/IsVQeVoRP8K79+DPQnw652
         rQbKGtHy8eV+bYBOwv76g8z+e6IuuBLKiiT++Kqk9gkqYdEkJCZerRvf9xtB7iLVGOt8
         KX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630371; x=1784235171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IyTe0muG2yLwepIh9MwU4EFl2Y0p6e17Fb/7mFLehhg=;
        b=aKAAuJbUSEF701yd2iKjDuexID5XkODIiovPyFeE/LzkDs629c9PbtnT2YG9hK89W+
         X2wT8L1Gjz/F77vpHxCfgMR+fGZImsFiCVvWwNqjBD1NjQHmntGmy3Vg5fKAVzfQenhf
         3sHjYTutdFVD2n335hahVvoM4QM7jl0dZBpsI51pxuSc8x97lNOrpOo/766rw9IptMqP
         dRkdBM54fbuI9GXMX4Mlvmcvflrmvp9KjJ6M4pd9mpQuK6azovK3nbW6KMuOdjBNuoNC
         wLomU6UMu3iIZMRtXa8/d615C1HMB+cbEXoJzli1REQxTabJ/t4QcDer4QDGcS4dfvMo
         WsPA==
X-Gm-Message-State: AOJu0YxpxJVYWxgwjPWSHEkc0dmo0krQDJJkNK+iYRS7oeN7IXlbCepn
	6LRDY4gNC1mC7UF/OwpeEcf3zG1AUuoxl6eVjXu+QbGD4GrbmUG6NZmLDDUTig==
X-Gm-Gg: AfdE7cnrsplR0eOoYsxcKQV54Hrgr3EB4TXD9YJRejCe0U3hHSQ1TCS5MzMJiOkNESS
	l22QXzGZCCwDRahBK74BkejamDe7zL4Oq1ioGrFuXRerRsokpywgmq4AWJ6TCuiIRM4fu1bvZTr
	KmhCvL2NieCH1+xjtuwD9F0UzEMuEq8KsK24m2sJdX3ZfT5T4l1Mqi8NdLMDWP3+mfcXLZPgWVE
	fBEih3wM4lvUaE+A663uoci10vOLiYcKml02C/cJ41zriP26wCAEVHNUzYkYnNiQHLOt3DuSJ7N
	sVMTjGDruYZBCer7qFmpmSser4ObfIghc5wr89iR7Lp2fczkUFTFBUPIMmeswguZa7N9WXZyhTs
	JtKIY8V7wSvMIBGhwAPYnBVDhfMHCJ2o9Bax+OuehUoP+ip7hHlrIMSqBb26mpbEWVnoHO+HL3v
	gW4brgrtTUsiDLndo6EAY91dcVVfcwT/fjEm0IVaj/UKMx1f1uHX5Itn3dktwtT6XlLg==
X-Received: by 2002:a05:620a:2703:b0:92b:d4e3:1f08 with SMTP id af79cd13be357-92ecf6c6ea0mr1012778685a.55.1783630371118;
        Thu, 09 Jul 2026 13:52:51 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm32893085a.38.2026.07.09.13.52.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:52:48 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 3/4] oe/path: canonicalize('') should return '' rather than the cwd
Date: Thu,  9 Jul 2026 16:52:26 -0400
Message-ID: <20260709205227.3470712-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709205227.3470712-1-twoerner@gmail.com>
References: <20260709205227.3470712-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 20:53:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4462

canonicalize() splits its input on the separator and, for every token
that does not contain an unexpanded bitbake variable, appends
os.path.realpath(path). It never guarded against an empty token, and
os.path.realpath('') returns the current working directory. So
canonicalize('') and canonicalize(None) produced the cwd instead of an
empty result, and a stray separator such as 'a,,b' injected a spurious
cwd entry between the real paths.

Skip empty tokens alongside the '$' tokens the loop already skips, so
empty input canonicalizes to '' and redundant separators no longer
introduce phantom cwd entries.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/oe/path.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/wic/oe/path.py b/src/wic/oe/path.py
index 13c52b363694..95bb9648fab6 100644
--- a/src/wic/oe/path.py
+++ b/src/wic/oe/path.py
@@ -355,7 +355,11 @@ def canonicalize(paths, sep=','):
     # prefixes in sting compares later on, where the slashes then are important.
     canonical_paths = []
     for path in (paths or '').split(sep):
-        if '$' not in path:
+        # Skip empty tokens as well as unexpanded bitbake variables: an
+        # empty path would otherwise reach os.path.realpath(''), which
+        # returns the current working directory, so canonicalize('') or
+        # canonicalize(None) would wrongly produce the cwd instead of ''.
+        if path and '$' not in path:
             trailing_slash = path.endswith('/') and '/' or ''
             canonical_paths.append(os.path.realpath(path) + trailing_slash)
 
-- 
2.50.0.173.g8b6f19ccfc3a


