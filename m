Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF780D111A8
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 17:53:33 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.493.1764266007128841178
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 09:53:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KxThmMcn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so698819f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764266005; x=1764870805; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XQp8KigTr9SlddI7W5VRpbpKbGjIVwd+mQVt7y5pKQ=;
        b=KxThmMcnGd/Hzf2cQ1JmuDX9zeNFo14H98Ogbd0mcj5C4n1tLnL4HG9u05NZqE4nYG
         LLPtP5c8iwySZxtdJZGbLH7QqHSPj558UJ+rfrmp2y9uRbRUFQXT5l10UG+qNv+TlSLf
         3n6EreA+YTSRxk+oPV63MOaJE/dYyjqKi+80o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764266005; x=1764870805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XQp8KigTr9SlddI7W5VRpbpKbGjIVwd+mQVt7y5pKQ=;
        b=lVFoCcEAbskuoXz4O9FsV+rgIFWCGAto/45cjV17SNpoasq9qbhDuxFS6BBWltacYb
         gyJgtjgTFAthvWJrkJiU2oA8XXrWYIskYGajr+nTjvXGR1e4eyx9EL0Fe3OmX6Fi3Vin
         xzu4OmUgou0lvvC4LG7zfmoO3KT/by3BRaoMuDZw0MVEchf0akZccnECC7S++KKzazxR
         FaGa77JCCWUWisdVElU5jAnhNjOwK6pZehHX27d+HjCuRkG9sySGP/fJ7oBzxQE2W3gy
         AbYCQkMKfAOWW63geFaas/gbR7kwrD8v3775Dfjye4p19cwnTsUZ2eQGbSKr7PnYpyhB
         4PNQ==
X-Gm-Message-State: AOJu0Yxrrj92FX2HXzD1dpz7/I98ouao83GXmKd4D8R48egS8bNHKz9s
	uG6ah0i48WOriTMcfIXQPAwRfiBAJ67NYvvWJUs7+meh6GQPPRKWL0H92dL3aUChXBfd3opBJPp
	hk9sR
X-Gm-Gg: ASbGnctSRCBsKQaDtKHmDza+kZwxnMBcH/88nUCy7cT3c5m5DhSaB1Jt40Mc8PpDZLy
	omXZNcY0VybHo+1uuZBLf7UQZP8+me/Vh1MLfqTH14AJuDy/YaWwdVpl5GrQFYKecsPJvHRhAB7
	v9o1VqMjYH15BmhcZX8fILy8XWgiXd+Ai/twK9dymwNfOYStgn39YfcaXK2KvaFGadVh9Z1BCoR
	btnrDnHzumB4EvKbtPzFGt6S7dQHBy7roK+wlrySPff3dpqsOlrUog3UxRoRCxfWeGgRVbFL4U7
	mt5NmwFPoqXbPODqKc7CZL9VAW/4pyC97qKcS0fYjDFc1KokNpnuPQoW+KPjON/qkl64e8OH19G
	8JcebJn3DRYDZw/ARON/tLhi5KkVTJTlifSiMJ1FjKLt/BinsueLR/R1OpF3j1bGgD8rY1P//iN
	6/llbdCNbppRQq3nmZrVsroK+xNYBAkKJpI66gvbo=
X-Google-Smtp-Source: AGHT+IHA3II4FQEoyZDGtKsrSEmhCpoCfA+xFPsBBMarJVszVUBxa+j4fZ7vGKCN90bwusTxTDZJcQ==
X-Received: by 2002:a05:6000:2c0c:b0:42b:4185:e58a with SMTP id ffacd0b85a97d-42e0f21e2c0mr12741009f8f.14.1764266004977;
        Thu, 27 Nov 2025 09:53:24 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:49e4:7f15:9d56:4465])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d618csm4674228f8f.14.2025.11.27.09.53.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 09:53:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/getproperties: Update to exclude tags
Date: Thu, 27 Nov 2025 17:53:23 +0000
Message-ID: <20251127175323.867382-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 17:53:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2724

We're interested in branch names so to resitrct to those, exclude tags from the
command.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/getproperties.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index a0175c2..39930c5 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -21,7 +21,7 @@ def get_revision(repopath):
     return subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repopath).decode('utf-8').strip()
 
 def get_branch(repopath):
-   return subprocess.check_output(["git", "name-rev", "--name-only", "HEAD"], cwd=repopath).decode('utf-8').strip()
+   return subprocess.check_output(["git", "name-rev", "--name-only", "--exclude=refs/tags*", "HEAD"], cwd=repopath).decode('utf-8').strip()
 
 jsonprops = {}
 jsonprops['commit_yocto-autobuilder-helper'] = get_revision(builddir + "/../yocto-autobuilder-helper/")

