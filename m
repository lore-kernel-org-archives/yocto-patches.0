Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44CCCA490
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:33 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22513.1792361005879582538
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=d4tfZbEB;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so853599a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361005; x=1792965805; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Ov1YKIf3O1PBDWKDboyrOa0zyT5HSa80wmEE6eU8+E=;
        b=d4tfZbEBaJLDh6NWr8h4slCmjdntDflIFRm+Mm98LKsn1F2vXRBWXaueVPpI7YBIfE
         /8ILU0gNNjQKBa6u9n84b1r5qoQSSick96O9J2kLQ9mJwgHdPUW+1NEVpO/lESVP2Rmc
         /kHced0GoFv+oSxt4aQVZYE8N1hVWlqDaht2PIaO6OTNVMWdUW/TePMamgL2tIlSp6CG
         cCKYhv4ibH55eVZgKuP1om5Qfrzs+NvA3jDAcGfT0aW83V24/Ob9cuaNwhqFBbnCeE/j
         Z9rqZLrRZsAdNQdXnD4wr9sQddmv+6MYcLiLZ4HYsN8HY0KpKQGyVC2JnRr058e9DGH5
         tlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361005; x=1792965805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Ov1YKIf3O1PBDWKDboyrOa0zyT5HSa80wmEE6eU8+E=;
        b=XKlfkqYKHzKxEbwRJO8RCaSU7G1MG7so6k9VuDyVRl5GFzpplx0yAVL8dGNboFizhK
         HDaDPAcoETuOGWpaGs9PMIQ08XWDNRRstfhPDzmMIMJhZRypynOdPQIW1AufGuU0Wajr
         WX5/rbHQMDG1HI3irHio0wqPEewZ+B/nP1EDHSHd8pqU5pGEeFUuGRzdzntjI++Nzk96
         tjaIn1uf904Nu9q3M3b+ofiWohWCzRAYDM3iry8MHeL+YNyijQS3hoNJ2G9ByrQ539dH
         aaTTlU9xU7D3aAn4TXItQhuTNa9PbW1Peou4RJBCJj4BHiof46+PucPp4RgouBXyjx+J
         bLFg==
X-Gm-Message-State: AFq9FYLeQqdLIU0YTc2Tk1ApEA/Rja3ubR+Z9J++nHxTv8ieZ04+mcdk
	1X4LY44s4MIMMUKRr8WbZ39x0JLaiwW8RiRzDbL6l+GygUJ+Yb9H7l81rNFo22I8
X-Gm-Gg: AYBFou3MwGAAdqD3vvu3mzJ/JMFk0ccfXxMR4lEmpZrwrzzx3uh1r7xO5C6tMzjsv5Q
	M453tt+E+20Du0cqTE2NrmH6QQHVZztNN49SIWHhNecZLdZd1WoyTLE+BkLdzWqDgfgi+nOKJYs
	jdZDzXOYPfHeU+wpNTn2CyvXt0ytJ93CLMgCUJog5awCSLGdL8HnTUFDjfhIepeQJLCRBl24Cg2
	Sz6nVxWen42m7O8HDIE/LzItuetaLjEmyXCKfy+Q01kpMnfFfheYpVB9ED7uoeZRzPDIeJdF8Ko
	PJOxH5T6PjVK2gt8NCtjisShTa6OT7bIUW+NmrPad90WIxil+rdtQxfV4fGC7kP6YIrZp1OwRpb
	IJ+20wg6hJ+gHPelYDBKR4km29IFlo4vJadMczZ92DBTgyvOWK3pp+ad8w0EMlreVBeRWmk+4Wa
	BTB2Taefcwgz+0Kdnol4Le5BfJ05pwXdRfvf4jEAP9ItxL4Lr0tmAsXTtbHvUxbz5aNu0wkf9IG
	JTV4iPq5QjTDK1DEFQ7wNnXRSjUzOU=
X-Received: by 2002:a17:90b:264a:b0:3a4:6e84:e7d8 with SMTP id 98e67ed59e1d1-3acef58d5eamr5119271a91.54.1792361005212;
        Sun, 18 Oct 2026 15:03:25 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:23 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 05/10] Rename the README files to .md
Date: Sun, 18 Oct 2026 15:03:03 -0700
Message-ID: <20261018220308.72731-6-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5087

Rename README, README.devel, README.rrs and README.vscode to .md so
they can be rendered as Markdown. Only the names change here; the
following commits update the formatting and the references to them.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.devel => README.devel.md   | 0
 README => README.md               | 0
 README.rrs => README.rrs.md       | 0
 README.vscode => README.vscode.md | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename README.devel => README.devel.md (100%)
 rename README => README.md (100%)
 rename README.rrs => README.rrs.md (100%)
 rename README.vscode => README.vscode.md (100%)

diff --git a/README.devel b/README.devel.md
similarity index 100%
rename from README.devel
rename to README.devel.md
diff --git a/README b/README.md
similarity index 100%
rename from README
rename to README.md
diff --git a/README.rrs b/README.rrs.md
similarity index 100%
rename from README.rrs
rename to README.rrs.md
diff --git a/README.vscode b/README.vscode.md
similarity index 100%
rename from README.vscode
rename to README.vscode.md
-- 
2.56.0


