Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E52C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 08:20:42 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.25528.1750062035500924563
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Jun 2025 01:20:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=k2H8GlBP;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: skandigraun@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2348677f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Jun 2025 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750062034; x=1750666834; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bri6TfdTznULKvO+jR8o60EYFRUL3vht+bHoWJe6SJ4=;
        b=k2H8GlBPB7NpRSbl3b7gWdOeqWnMOsll7O/R700JKtWGMpGcNB/7x1Djnpy81jpMBv
         0rxs3WeqWeSlodi0EHMu7qO1JK9FfHt4+c1OZy+RDzRMLhVv616AXsnOZSd0mm26Ul2H
         4gcbb/LecV+aoRFJgTthDkPpuQyLV5qtG7G+Mfu0jo8B4CMlLH5MmTEbSpXNPkXg1ABG
         fKa/IP94iGlggqKxaLRAKISn8dbiHWIdOH8UfW+eU2JGMrx4ShK3IZ7l6SZcjP+a3u/4
         43qPbdPYeowtDWPQfJnhJd3wsMmZOWhuZ2kKnJUpArJDcwFu1rhWO4xInp7xDG6KFnQf
         kXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750062034; x=1750666834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bri6TfdTznULKvO+jR8o60EYFRUL3vht+bHoWJe6SJ4=;
        b=b+iHUJc2k3MNxB980ZpzmpOALwkCrMPtbNlrDieWxlus2qWQ4ywf36qeYYCdylDe7+
         czDfGIETyUQn1UrQsVWXvkgzcQvX21omoa4W2lWLSdMnRneB80lL7GN2q16qEBw6FAXW
         GQTR7p+DtC8PuxOanRh5OB2CuGFywxXAJrnDzxi3cIfvIJIuXwyEAxxHn5/2A7NQgbZx
         Jkpme03khWIXf/CS5aRmJ/UWdbiwcskKrEvwqzcLcORHkwtg0TdZKYZhgSY6uSd90JYi
         uG2iEUh34kuFSRMH0mxNCOOuyJvID3m6eBJ+08XIGPzzmvWL4ls+0Kdd8Kgo83dKcpFF
         EfYQ==
X-Gm-Message-State: AOJu0Yz7RMYjx8t25cQIOXwKMHsz1MU7B38wIhPdGnAtKOH4KMrJAjcR
	jv/dm/9ISe7sasAO5l+34RMtIRIazCv0yqpzzaJr7qUCqOOJwIIDXJCHh1m2EA==
X-Gm-Gg: ASbGncsKf98WDpCz9s3EPA7Zw5GZueCxu43jYPOX3EYfZ82Cv1mlp3PIgwn14ljbk7J
	ZUD7tsFoFDFO8XA66iYCEJ/twQ6+V5lp0u64Toarr5IklH1qsQj/Yd3OC6yOI/aoautkwp0kIcK
	7xIKsHCDDKwpyb3/OVgd6wIe/Z9pz2P4IPHwE8N8FEYIdqBD4p4T94luc+m+M+ehevDD598vTZ3
	Eyz6FHfwQXJahrZM+SGhi1Evj5CBzhpXdhRHQzXIPCLdh0CTKB/VCjLzuyVj1V0Wx9nAxYWWCgy
	/+F6u8JF/zFh4zKE3bItrzpmsTSONU70XqdYNUQxiFl6SQ02gcQSC6OAj7gTacDu/eZbpA==
X-Google-Smtp-Source: AGHT+IGXRO0mA4o/F2yxVhXC71Ej6aJSXNvP8//3iP/x+SlUqO27+4IIPkFgpsC3qTcu1rXaB+jVjw==
X-Received: by 2002:a05:6000:2001:b0:3a5:25e2:6129 with SMTP id ffacd0b85a97d-3a56d8347f5mr8920303f8f.21.1750062033531;
        Mon, 16 Jun 2025 01:20:33 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4b67bsm10209290f8f.83.2025.06.16.01.20.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 01:20:32 -0700 (PDT)
Message-ID: <fac4f8c5-cb23-44af-91b1-321ba5fc4ec1@gmail.com>
Date: Mon, 16 Jun 2025 10:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][Build error]
 Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
References: <13355.1749788690158478865@lists.yoctoproject.org>
 <13137.1750060253705028741@lists.yoctoproject.org>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <13137.1750060253705028741@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Jun 2025 08:20:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1648

Theory: I *suspect* that this[1] part of the installation code kicks in
- it checks if a toolchain is available, and if it can't find an up to
date one, it tries to download it. If this is the case, there are two
issues: the toolchain should be available at this point (from the recipe
itself), and by default there is no network available after the do_fetch
step, so it (silently) fails to download the toolchain.

I think this could be some pollution or similar breakage of the native
sysroot.
Have you tried to explicitly clean all the rust/cargo/etc recipes before
building the latest version? Also, as a test, it could be interesting to
see what happens if you rename the rust recipe to something else (myrust
or whatever) and try to build that. Does this issue happen that way also?

[1]:
https://github.com/rust-lang/rust/blob/1.85.1/src/bootstrap/bootstrap.py#L606


