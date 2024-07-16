Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C93C3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 15:07:20 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.13109.1721142431343398874
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Jul 2024 08:07:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mxJZbl2K;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5f128b18bso31299016d6.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Jul 2024 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721142430; x=1721747230; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maMcWR/GQZGmDf2qDwpX/vhBr6cJTJ7+oF9V4Err98I=;
        b=mxJZbl2KwQrJOg8I7Tep3d2M5sJgeCn1RJQ1aSdPzUypG9BKbmEgmRZWwiPQvSXDf+
         3vIxmV0ky97QPQdQsaPXa/U4Nik7DTc0TELMPXLltwnNmZEHQogqxZtZG4Qts4JWV2Bv
         0rBsAIfWEDDip4fhQg3wCZ5e4zaAlW+5T8opypaEbXU5rMxWvCwrtZDoma9Hcdr5cfRx
         k+ldw8AMpEWS13N9lAhYsntiljdwkQ+b4s1SrmtgBB9U0PxQaRSEMRfXi3LXziuOf9jr
         18MgJvH7XjXirNt+eGTGiUsBNBOQFtiul37h0guHdLcfHx3JN3h0CSUcksJS69b3TOsr
         q30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142430; x=1721747230;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maMcWR/GQZGmDf2qDwpX/vhBr6cJTJ7+oF9V4Err98I=;
        b=qugjENlEzcZ6wRskOrYww4iN/kmTxq0BJj8BRBLbbcFLmFBbREpBBzRglOH0OmKyjP
         91Gc4H+xlYFtRng//l1I6LC57FOhOGEKKqm8RXiCz2uIj5qpEMoRjvOFMUanuU2JiqKi
         D8Ezk4J6aJJ8vWg2twanTwAuySan1130cJdIjCIxeU6GDJNIqydyFf/hhGUwc/A2Jex1
         Hzkz9UBHZE1IGoKP6oQs7IKZ8YxFInhzTRiXVd8W82j80HChg3py2Ebp28hRJqLymWro
         bloyAsl5CCkxOPbmDxF1fswQDDTd7toyh5exapZ9qjAdJZRw+XRsBiLNqz1cQAr/zwhF
         Xxpw==
X-Gm-Message-State: AOJu0YwUZiF7rSy8QluowNGFN4q78/ZiLPmXE6NrrE1s+MVPnwKR/GxO
	Agy9ObUVXwSXpymP4X2fIO5sHDqvz1Xta0eGWqftm6DlvXF80RPTIYKB1g==
X-Google-Smtp-Source: AGHT+IFxSm4b4PVxmbjlXTqc8grySdax+NKckrVMiHvofhU5KpobAhQ1zUxHv3HVsIOcYgm3iFst4A==
X-Received: by 2002:ad4:5dcb:0:b0:6b5:e6b3:72fd with SMTP id 6a1803df08f44-6b77f52cfbfmr31522106d6.29.1721142429536;
        Tue, 16 Jul 2024 08:07:09 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76194fe1bsm31485346d6.11.2024.07.16.08.07.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:07:08 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:07:06 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH] linux-torvalds-next: ignore TMPDIR issues
Message-ID: <20240716150706.GA21168@localhost>
References: <20240715143149.16336-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715143149.16336-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Jul 2024 15:07:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/432

On Mon 2024-07-15 @ 10:31:49 AM, Trevor Woerner wrote:
> oe-core has raised the status of some checks from warnings to errors. Ignore
> the "...contains references to TMPDIR..." error when building the
> torvalds-next kernel.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-torvalds-next_git.bb | 1 +
>  1 file changed, 1 insertion(+)

Applied to meta-rockchip, master branch.

