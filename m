Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABACD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 12:48:35 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44582.1781182106237977418
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 05:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RN4HLHtO;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517b1f2c6adso46858011cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781182105; x=1781786905; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qoJz/dPZYppsBWJ9c/A43/Wgn+vikinmef8XqeLaeoo=;
        b=RN4HLHtOZbq+P4jxw24aGs8IMr05J6b4OCXT+DfLk3x7wQdVS4/9DFjXXPAZxpLrl4
         /XprGP9CZlCnlICS6FwxAAt6KMPLWCj5sjUmY9u/pfUBu6xVHu0dFYCNAkJCgONVqgOG
         bgERbDvoehOu+Vj1jaS8lQDwYGRPyAER5Q0ju8AjlBDNij82mr9uStAa6y1G+fkOO8Vl
         h/dBXMLcb24P5V9AKLRI9leZFiFT5pdYbg2y0nulzxBsxH1ziSmQRJqwXYfXEOkS4hIj
         1VTFy0c6dE4oK7vuCKyX5gp7jXYo+shUc9AreuNh+DAzbG1qxaI557DeeIZfVENSMhHa
         OKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182105; x=1781786905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoJz/dPZYppsBWJ9c/A43/Wgn+vikinmef8XqeLaeoo=;
        b=HY4Ax3qlBRISDzoddDS4QVA6qTjrj7aXq0pqbYz2OuNnMgR/Vv7ztSKZQ3OE0hoC6J
         y8C40Q7xQcnYdttIFTLfW+SdcSVHcO+y3n0F8y9x7N8Mik3yJfREI93ErZBf3oZ9Ody9
         x1H69u/1z5pKdSHod8gs7hdHQwkn7mUgrboE9+nUtAVI6CRtI8zcNUdhxeNew1EhehGk
         GMp+R32eXJpGMAHwh28OSucBTIq/bdLNaj7G1CuvoAnQO5/06MheEceKNk2W5mg7Ig9c
         YDWRnllB6mwr2Ert3I4Ftt1nRzX3N10lzIO+OV2JyF3PhaiU2wpialNQeWsxgWRR0Osy
         tmtA==
X-Gm-Message-State: AOJu0YxqFTf7St/meWTeGgWpVwTYAlGWZKrQBdn0HgBavXPS/IHk6FsU
	n0CfB9zXBH20VtuMlBdd2jNqSKYSOKWJPAV/DyG0nvVbkntIkGhWOSKW
X-Gm-Gg: Acq92OEWkyQkSOMlPl17tp6kOTtY4/XXBbvE51JwO2QJpAy1ygjxZucJpUBnjGSeHqK
	rgyPyPBGDU7vNNHkSApwZFQYXXXqM++MKPmLjc3YOw2V8KaUg8EqFQQgjth8gt5MVyiaBw0ivVP
	up/gUHj/I3JKS/MmDgfTRCwfIHTnyAu1IfHiCjLvebwb5T1Rh3s8kXK0Zn9U0L9DYEZ7Uuo9qw6
	Mknr03Gm9N00igZF5LmQq5zvoPAkONbtIBdvKvfOobQFtUySxMA5Z9I0iVO9SiAjX7EWXHhyKxI
	S5+Gk1ThI9k4YZeTCzguUgSVhi4lXrVDqZbSP2FXwLastUR2qcdJwjBGjPe6CIHpl0aCSlhcbiB
	iUzv4tJ91TWYV6qQmCxViU193U/FzAUYTQVBTxzb1daH0Cherxv8zyM+QIyLYtWsPbYYpjTMlGi
	atz+Tk/xess+x5CoPaU9D6MG4P5UOxjcyeiXDH7jsuYRTxLQQnRA/spLXGQypgrzMgW4zAptYkV
	ZQ9
X-Received: by 2002:a05:622a:1451:b0:516:e086:89a with SMTP id d75a77b69052e-517ee23c4dcmr38848341cf.26.1781182105167;
        Thu, 11 Jun 2026 05:48:25 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef623243sm16387941cf.23.2026.06.11.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:48:24 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:48:22 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH wic 2/2] README.md: add Trevor (the maintainer)'s mail as
 Cc recipients
Message-ID: <aiqulowvm9FN-Wug@localhost.localdomain>
References: <20260608-to-cc-v1-0-a1e3e7462875@cherry.de>
 <20260608-to-cc-v1-2-a1e3e7462875@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-to-cc-v1-2-a1e3e7462875@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 12:48:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4211

On Mon 2026-06-08 @ 12:47:59 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The instructions now match with the .b4-config file.

Sort of... I believe the b4 emails will read: "[PATCH wic]" while the
cmdline emails will read: "[wic][PATCH]". No biggie, I'll find them
either way.

> Suggested-by: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  README.md | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to wic, master branch. Thanks!

> 
> diff --git a/README.md b/README.md
> index 0066ae4..3259019 100644
> --- a/README.md
> +++ b/README.md
> @@ -57,9 +57,13 @@ When sending patches, please make sure the email subject line includes
>  "[wic][PATCH]" and follow The Yocto Project community's patch submission
>  guidelines.
>  
> +The patches should be sent with the mailing list (yocto-patches@lists.yoctoproject.org)
> +in the To: recipients and the maintainer address (twoerner@gmail.com) in Cc:
> +recipients.
> +
>  When generating the patches manually, this will generate what's expected:
>  
> -   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix='wic][PATCH'
> +   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --cc twoerner@gmail.com --subject-prefix='wic][PATCH'

If my understanding is correct, in markdown, in order for this to be
offset as a proper code block, it would need to be indented 4 spaces,
not 3. Regardless this isn't relevant since we're not hosting (or
mirroring) this project on github, and the markdown renderer on
git.yoctoproject.org doesn't seem as in-sync with github's version of
markdown. Either 4 spaces, or wrapped in ``` delimiters.

In any case it doesn't look like the git.yoctoproject.org markdown
renderer understands ```bash blocks, so I'm posting a follow-up patch to
fix it all up.

>  Nothing, except running `b4 send` to actually send the patches, needs to be done
>  when using [b4](https://b4.docs.kernel.org/).
> 
> -- 
> 2.54.0
> 

