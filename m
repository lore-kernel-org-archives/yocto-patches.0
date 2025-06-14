Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450E4C71135
	for <webhook@archiver.kernel.org>; Sat, 14 Jun 2025 00:37:13 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web11.1591.1749861426323519402
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 17:37:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ARytBRYF;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86d01686196so91278739f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749861425; x=1750466225; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IzQq0LkJBxe10cKBxJQxhkvVuXITx5mZekxFupe5Hw=;
        b=ARytBRYFeYMlFd5aTfnekqxHTWqz+z9bid22FoWjhsLOxlMCuABxkk2gQ1WUi9fDE2
         xkLjz8ZVqAM5Hk0E6tpuBxrdBIzucbS05ggJwq1dI4pgc2/EJDOEIs0p+Yilk1h7QkDu
         HzO15uCdXdIRhQ+Ln2D8P8GwRdewUmgnGU6xhDvZ3Sas3LXotWRwFGXYnQ8n1nLRSyMm
         VUXfcAVdoakqGavczy8d5Ea/EP6Ti3EobcgMwKXCRpI7mknNy53DiK/hFVVucz8TvTQX
         lPw3txU8K8atIKKfp4EQCYLzErOhq1qorL+cpKqIppsE4PNKpdPOXffdxvNG5co+EtJn
         XtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861425; x=1750466225;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1IzQq0LkJBxe10cKBxJQxhkvVuXITx5mZekxFupe5Hw=;
        b=SdTPLw63YMIZ4uwc7GPY9FYcQZEawd8VBMenSdzpnl/0J5YETPB6hWON32h4Bn36ZL
         JI1nks8Z4j6ZuOFskd4Bs47XqAH63YEhl4DSNYM49cCadd13SO1F7VXUmZbjgb3emTc2
         e1U6FNeKQC11v1/43yrlc1T2l7c7weLQifIyVoiJ0qTMjcP776dcilL1M3neZjJyX+kb
         jcIY+YlqOonl4sFaa5/tvAyoaEubOkJznDDFZtvaIe7hRtnLDjWpLnfm0Y5+uyAhnuO9
         JmjDZgYImo6TW6oAABsIVoD+rKDyHVwOyLfOSR2IN4B+dAWLTI/r3dPAdjHGvemMTrUi
         Ss+w==
X-Forwarded-Encrypted: i=1; AJvYcCWYXlvMudopKDNRpSTuAHJl+RB+jFOOS+3DfBY0C/3KLgt3Mw7ynSTNjOfYyiMldRF3fHfnFhOf7R+HuIHx@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yw9Fxth61I165Bnp2i9gxy1wA0GHR2d9zNjQs+VMTg/dLz5R/GA
	HFdF8cKRalG0KGYyWGvC+o04fSeQFpttR7FuY2VkAZKB+sEKLORA5OLt
X-Gm-Gg: ASbGncsaF9RlTGIZgAHYe5S7JX1NV14MGm4S9P+C1V0H3WhDxPyKd54uajjImGlWZD8
	cqgm4k51MBAs6RjHAzZGWWOZbdKedqdvowGbJ2vz0K3UvPW0qw4dpDEbyzlisL3QeBGfxRRJqoF
	HJvhDJL6/QMVvJsliA/zLaCzMO+vgX5NcmqZcUoX1sh7+b/Lsp90cDKK5oQzgeXceQ3iOOUfmPu
	bklsOOoRfaAo92hl0Z7DzUzdeEGuSM+J6V0zJt4tl+iXJDOGFAyZ+fq4fRBe9W3hT+8QRFsvGsX
	Dn8x1kkKuYea9Iz8TDmc22KRoVmk4RTE2gYmu9q3XrC5nu4/XABGRSqfZafcWRubD1vKtJSvAQx
	AL7U0Te8I8/vijiOQl8GjQP49vVPqI2Gvpgz5Nc8=
X-Google-Smtp-Source: AGHT+IHuQKoEjgjJiJcNtXj0ZdNd8nFP72cwELjhbYZlZRdmv7ZhOxXKGYvDOojYPlOqVFvIE1Xlaw==
X-Received: by 2002:a05:6602:6b83:b0:85b:3763:9551 with SMTP id ca18e2360f4ac-875ded45b26mr170449539f.7.1749861425477;
        Fri, 13 Jun 2025 17:37:05 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149c858dasm533078173.109.2025.06.13.17.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 17:37:05 -0700 (PDT)
Message-ID: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
Date: Fri, 13 Jun 2025 18:37:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
To: yi.zhao@windriver.com, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Jun 2025 00:37:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1646

Hi, folks

meta-selinux carries dozens of Yocto-specific RefPolicy patches [1].

I opened an issue upstream to evaluate adding a "Yocto" distribution
[2].

Looking at another recipe [3] with similar upstream considerations,
there is a reference to "openembedded" [4].

Please share any thoughts or concerns.

[1] https://git.yoctoproject.org/meta-selinux/tree/recipes-security/refpolicy/refpolicy
[2] https://github.com/SELinuxProject/refpolicy/issues/905
[3] https://git.yoctoproject.org/meta-security/tree/recipes-compliance/scap-security-guide
[4] https://github.com/ComplianceAsCode/content/tree/master/products/openembedded

--
Clayton Casciato

