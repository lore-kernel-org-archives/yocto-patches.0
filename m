Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE9CA5FB3
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 10:46:51 +0000 (UTC)
Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8050.1790851605306083892
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 Oct 2026 03:46:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IExVtWor;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.88, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so4948643f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 Oct 2026 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790851603; x=1791456403; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GrxihWQdio3D2tno7FBCkW8vtPApjF2J/oIw+BXg7sk=;
        b=IExVtWorqwRaA48DS3/gisYXpDtvlmIZqp3G5lEkbrYMk/QF9rGKTDwnXJkWY0VRXl
         Aa0R6UM4UIuh2efzqVFcaLpu1LtLYPYCACyDSjKTaXmBW2gwuNBFvWTHtXmfZkcduGze
         0ja7yT9FLM8rDEkma5l3YKzWvvWnGPjNjF1bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790851603; x=1791456403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GrxihWQdio3D2tno7FBCkW8vtPApjF2J/oIw+BXg7sk=;
        b=h+BJXbTPJLB2s+Tr8QMcwq8q33uX607A9JDwD78TNZMPXmrWOgMwUwpAFW9hfzHOM+
         cmgY+uE4kMGYvpBabNIV+slPDfFBrnYR7ilm//povMhLSJJAFDZfoxCt4f7A6TCSbFsC
         Ry0sXILgJVaXxYGiumsWwv3/0BK9EqB2L1TJ825nPPe7J1tbpOWwzFHVY6J3cD72fWpe
         ZgL6IsDBuEL6eccwNQmumNWbxPqzcvmNVFLsH7jJhuBG3WveKK8yf+mI454znPr6ygkT
         wpdzkP3IdYk57KMSoxxa0I1wZRnTAV/mh6zUpdZPWKJlEqD3OSbTgJeQW7D2wq2WANHS
         UUEQ==
X-Gm-Message-State: AFq9FYJXry8doL7xH7fL51FZlTsdfIU6lVTbIXVAy4ClkkiRvQh7d3SK
	cDHC4/tAcKk31v9zdn6rzYWFnJ/q0/uCGQxzBo4xuEgjNt1Sgu0GET3ZEnw6H3r4N5j0lNAEbH8
	ibu2QYYk=
X-Gm-Gg: AYBFou0Eb3e7CKOQ7uu6MtidLyQ+LlFCG6uy1yQjhZ5KFsJr4d9ENSwZZ8cZAqNRXsV
	3Mnmmr6XaBTqIgcJe/VphoY6cpwdFY2QoWMhV5X+ZSxGjbNotc2dh7aGgFo5JE6vb8x9PT5+teO
	9ECEQOMpQTaZWijbCiDRMTzOTH0jt3Jg/8VkyKNpJzPZAYk1rNZh21p581pOEOLIVeofbdoZ9+u
	t6EnJVQKafbanTao6X4ouqES5+0ybp0iOHP8DGmhOBB1qhqZqviWsHEAh7DbcS8q4RxS+75nGpb
	S7JkNNasDhBvr8rpuU90sBEBqpN5jdBRxXuoVawMKWblMEw0yD+kQyuHRvhps4ytacgqUW2gDGI
	BvZcPyCyU5PqDt+6E3WwVjQRuWc0mUrBfifHjmnW941eIQ9nbLZAtt2ISNk28vvgvBuwJTK871J
	dh22jBmTDGPdS/DsPvl6VFCNNjYRtKZ+VD95v9ZmcCoVRn5IBw3eLzXdBMGbD5zfWRbwu/yA9Gu
	BSI8JOqKOrLySbmeIOh0asJmYGloHKbbMKOjQ==
X-Received: by 2002:a05:6000:240c:b0:488:7bdc:6032 with SMTP id ffacd0b85a97d-48b02519492mr7667670f8f.43.1790851603356;
        Thu, 01 Oct 2026 03:46:43 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:97e5:70fa:8dd4:c479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a360c2sm5056159f8f.36.2026.10.01.03.46.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:46:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] getproperties: Ignore meta-mingw if it doesn't exist
Date: Thu,  1 Oct 2026 11:46:41 +0100
Message-ID: <20261001104641.1596895-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Oct 2026 10:46:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4975

We moved meta-mingw from check-layers to check-layers-nightly which means
it can sometimes be in the config but not present. It is find to ignore
if it isn't present.

The wrynose layer will be removed earlier now and never be present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/getproperties.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 0bafa57..583745b 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -57,7 +57,7 @@ for repo in sorted(repos.keys()):
     if not os.path.exists(layerpath):
         # layer may not be used by the build and hence not moved into final position
         layerpath = builddir + '/repos/' + repo
-    if not os.path.exists(layerpath) and repo in ['meta-security', 'mixin-wrynose-linux-firmware']:
+    if not os.path.exists(layerpath) and repo in ['meta-security', 'meta-mingw']:
         # Repos is specified on the controller but not used in the helper config
         continue
     getrevs(jsonprops, layerpath, repo)

