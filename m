Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F0CE7B0E
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 13:26:15 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.34651.1725629169646861367
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Sep 2024 06:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gR8uZiKR;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c352bcb569so9410706d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725629168; x=1726233968; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r9wt/JAI9+XomxlbKzwVTYOBDiz7v7N3EHa+Rl8hdc=;
        b=gR8uZiKRpgCKowRWnCe8hBjfGI0gwf7CB0Pi+fzteeUxKY5ei1B5BE5UVfrqt1RchE
         E30g9jU8BwkYQPtank5lPVoCvSsx7TZmlzfiZqJ+DWYbG3ytn2nrAohBs08VLCYWbZOi
         n0i51Mmp332NDnnmVKpjhckGhvOx5sVgl4aasU9cBCRlMRBACu1TZutG7ooA69OKDJE/
         TSyVQiWR1eajOq9BB2YaOfTzxQjQfRtQ2RrLG2QX3iqcMvBeA1jAGJ6CtUDTkmJ4YQam
         acpJP5blay3N1HMO2Co77XVBhOIk+pSFGXuegXgr+PqAB+tTIHtGf7GwB72rEoyw5OEj
         2qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629168; x=1726233968;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r9wt/JAI9+XomxlbKzwVTYOBDiz7v7N3EHa+Rl8hdc=;
        b=NURXGYDo3M+YaeSGEODLULPcjwwNVSOjAmO0sgsnqnVgMh/EMmX4iMj3BcgRU82FUw
         tuejBTWIYnXGBpHKL09ELzPOa2AUteJFTPCf7r5tX/H0188IZkXBF+1uHCzqe2kLrn0g
         f5cpCtJachiyksCPxlKjMdpulQsOiRmA94K+WvcuSsWUFT6m4zpy7OPuYZl8XHeeY11l
         9KEoysUdfrZ7fNeaRGNiCX+aVkfvphiH1eiDI51VAS6RghCMyR2e+qqB1R48pnAK/iLM
         kik9UjQwWP9TRVzUtu7CRCmZGTyF7H2zGp4j6hsVdK2oiARK3QglstMCwbUvJfvbyzj7
         2QdQ==
X-Gm-Message-State: AOJu0YzoyJMSp3pCQVOHuzz8UDuacl0itkBp6V0Sy1v8XvqM02wEc/hI
	1sq4NzmmZb4QAokU9wPePdtdxzYAThbhkbjtFZXABIC9kKdEJ2z5JG4rrg==
X-Google-Smtp-Source: AGHT+IHSeEi3x9GwjGes09a1TOSjol4bU0MAXF09U9dfc3111n08I7aULsyS/aIp60JgVmTjydL+oA==
X-Received: by 2002:ad4:44a1:0:b0:6c5:caa:dd83 with SMTP id 6a1803df08f44-6c52850bb7fmr27626546d6.41.1725629167901;
        Fri, 06 Sep 2024 06:26:07 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520315353sm16615496d6.94.2024.09.06.06.26.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:26:06 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:26:04 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next: bump
 to next-20240904
Message-ID: <20240906132604.GA16847@localhost>
References: <17F26891A7ECFEC0.18304@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17F26891A7ECFEC0.18304@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 13:26:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/614

On Thu 2024-09-05 @ 01:16:01 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Bump kernel to tag "next-20240904".
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-torvalds-next_git.bb | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to meta-rockchip, master branch.

