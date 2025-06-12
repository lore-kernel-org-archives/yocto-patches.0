Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DACC71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 18:41:17 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web11.2008.1749753672684125815
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Jun 2025 11:41:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aOxZ6gEW;
 spf=pass (domain: gmail.com, ip: 209.85.161.53, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60be827f2b7so1301120eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Jun 2025 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749753672; x=1750358472; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILpwRKsKmuRWYiu6TnCs7DzpcEryFWmHJ+3LksnGXSE=;
        b=aOxZ6gEWO8LlVun1O0BP9lbcQlpVlHiAlcfQ1Qi3DW5M+6wVq0ia3fwSwlY3DZi4D/
         u8UTRbLQuIE/p+Pv7APBCZcUdk6RvdUjnrpJoBoU9azE20S+rgXU5pWUvsezEebVxrRq
         NnCXGtBPRxjUZzmb9AVy7f0Of/tvStUSjNqyQ7gpkTxwHCpJBZswPCCVjQ8PIE6Yd94p
         K/pTcVm3myVhGuIakVE9pq3rjl8SCSe7GKYXAkIQcZ/T0pDXPR/ulufofTuFV8Bhf168
         ikXm7D+xaL5PF9knszwyiEmkeWKjmHx4mVjlI/2kkrHmawAMgcy9+aoZVgfAxVlRDfpJ
         LGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749753672; x=1750358472;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILpwRKsKmuRWYiu6TnCs7DzpcEryFWmHJ+3LksnGXSE=;
        b=a7xDZuvS6M5RdCf45g5zHk5rIqYbVfkzB57mEU06Fprh5+cyguzhtwOTKadikrKg7m
         R/fJ0wgAqk11p3kZQvEDiVlz3ezDVI4g+1KIq5Z925TxRpyLmvOAxAHWntXBDuoIsbO4
         pAp71S1T7W0zzqmcum838RiyiXSquJkkxwGDyaRyEDRpefyCC7u9Rmo/zoUI05mwXxPv
         FBmPGh1aWAv9L6WP2iWeld9v+kDWnJ+r6cDJOlhK7xzkE3vWIBaRDIeE+LPXwt4bjzWx
         u1OIbxmYsM7ymt6UOAJHUB5pTwOwfeYwZjX6GVd70gqqPKW7W25YbtDqXEX1d7OInwEs
         kwcw==
X-Forwarded-Encrypted: i=1; AJvYcCUOmbhUZJvO8NVi/YAu5dSGsjXSAKQpvHO0v5500aqnqBGAd+vPF/AHxY/pWHZMmVzuLOzhORB04EN4hiDy@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwonSa63uH6eKOjlHuyxoUVvUF0e59zL0D5WGxWgSRAbcQxTOdu
	uBHd1KTHkG2Gzrh6utXDN+8XIRA8q9iUPi3cRTVeV7g9Ca8IYxaJfPyuoAM0Cg==
X-Gm-Gg: ASbGnctdplif+RaQyZx0UcMAO8xiSllSRAS2sU1cAUMO7IdO1kLjlJPtZwbCOx4tyuL
	hJbQ3BqVhUrYegtrtfkItTWmrRFB/S6HyqR0SVh4pEcOZilG6nBhg1NZSJYzjZKBeOQpLZiIczf
	uFIrou+JwHf34gdCV6umW91VRuRtj0Xto+d8nBgvojWzHWjkjatnJHPDR1cUmm8p967ETPtu0L2
	IMV0Cj+rGyRM8OuM2vOX+jzpdqdd27Hejro+oF+gDb+jr0WbWFNBbKrDtvPvHhN890NrKelrO85
	n9so/t8p6DVQcKGKKxi1+CC66syhtVT3owanyJuNXqSg7pgggdJ18qraZ9b5MzPehrT1ulRDDTn
	h+V+Q0H6U7XK6PihhNFzyOQZyF8wNKOTZP7byZQw=
X-Google-Smtp-Source: AGHT+IFUYJT+zzz+JUZmkeMpl5Lhl5g/iwg2VdZnJeuKhfb4vDlIckI0C9MjMfYOmDWwbe0w1zHGzA==
X-Received: by 2002:a05:6808:2e49:b0:406:69b5:36da with SMTP id 5614622812f47-40a72b17d7emr38713b6e.16.1749753671752;
        Thu, 12 Jun 2025 11:41:11 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fb580sm399439b6e.26.2025.06.12.11.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 11:41:11 -0700 (PDT)
Message-ID: <743e11b4-2009-42e0-becd-32fbdda21061@gmail.com>
Date: Thu, 12 Jun 2025 12:41:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][RFC] scap-security-guide do_fetch resolution -
 upstream release process
Cc: yi.zhao@windriver.com, changqing.li@windriver.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Jun 2025 18:41:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1635

Hi, all 

I've noticed scap-security-guide's do_fetch regularly breaks.

Sample:
"ERROR: scap-security-guide-0.1.76-r0 do_fetch: Fetcher failure: Unable
to find revision 616d4363527acb61c6494a97f3ceb47ec90f65fd in branch
stable even from upstream"

Something changes in the project's branch history, as the commit [1] is
no longer on branch:
"This commit does not belong to any branch on this repository, and may 
belong to a fork outside of the repository."

I created an issue upstream [2] and received a positive response.
I believe the tentative proposal will resolve the issue.

[1] https://github.com/ComplianceAsCode/content/commit/616d4363527acb61c6494a97f3ceb47ec90f65fd
[2] https://github.com/ComplianceAsCode/content/issues/13543

--
Clayton Casciato

