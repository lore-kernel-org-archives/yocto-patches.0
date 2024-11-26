Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0EAD6554A
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:33:34 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.53599.1732646006400989340
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:33:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fUcQYrz9;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b65f8cb347so218208785a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732646005; x=1733250805; darn=lists.yoctoproject.org;
        h=mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v+Qw8Hs8pQoolTfVn4IAWFue5/B3lvUUzc1wyAJgP+0=;
        b=fUcQYrz9jzhdi3BtACt6IXyx3vbnHG0Vr/PZC8vRTHxMm6QyTUD+jq6WK5i8MQoqJG
         BrFyhTsa5b7tJ/56aIbGAIhHOuTGvayn0VxNNNiVso/Pn0zjMWNon3xsgwmxLsLDwSSX
         DNcc4dJjS/4rEVVoHHHn8Tt1qHmuUBdpw8p9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646005; x=1733250805;
        h=mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+Qw8Hs8pQoolTfVn4IAWFue5/B3lvUUzc1wyAJgP+0=;
        b=ax+uYkoF6B8dH3zlsdxcNM/d/PCnfa6JkbRswoGp0RTIoGIHSLMqKFNwDoz9d0BYXb
         1svY03wxCmaWY0doSfqAzEYibfnBzfzh1YIZY1BX8PCn1Ak5f2ST8vQbLukfoTqOBQwh
         wHHoldTE+iE34x4XplJZKqSfgk4YOy3Oi3Jyp4yvbdc6JrXMBC5eyYodGcmRG8CqU8DS
         1hPtPbOuXFYuLqXAzy/JFKPzYQN8L4CNP8AHHD4QMQyruJBTvF79Rgu9lhOpTctEluhV
         DXUiAMF0IJhEM28/jBtFl07lEq7vRJW28vA0xq8zX1zmXBrWB0HdGF2lpgZo5BSppnaU
         oCWA==
X-Gm-Message-State: AOJu0Yy1QPjDY/QmkYTTTrjH0V99IBKt7Ascx3zftSitkzlxdPKAdIPi
	ipIQf8mn5X+rQSDvVa+jZ8NmcV17NMjV44ReqWb8oGv1CR/nZiAVZx6sgDdGBldKbfwiFYTaPhT
	L
X-Gm-Gg: ASbGncv7yqExxGQt6SW4yn10fZKIIxZbDtdczwu6wXHhBJUPQIoiPOTLpvsNBcKnGNR
	H6zENKP8nS+Phl30VGTEQFqmpFv60KHA8WzyCEA8Yjfp/4G2e+JlcW6ms6bzsGwQKLtS2rYtFq2
	Hyp5ohXjWQ3pJ41pfXbfgYznOJTOq2FYn/CTFg/Js91jg9LokExWfGYFrCTcDNuAODLFkZ1C9h6
	arrH06rUuqD4+wdzyfHBDn2Qbv8JIjIakKT0F5hMQ035z6WXIE6/rB8jBZBtCEqNxOSXkZofTYD
	+zrnb/jn
X-Google-Smtp-Source: AGHT+IFkbRjkP3BLUFaxbobZ9KJVRtzN4djvk+4yOEXue0PBu3ouHUdHaH9sj4apqqIO8hQIqHIsaw==
X-Received: by 2002:a05:620a:688a:b0:7b1:1d74:6b87 with SMTP id af79cd13be357-7b67c4b3f9dmr34298685a.58.1732646005316;
        Tue, 26 Nov 2024 10:33:25 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b676190ff4sm94433185a.84.2024.11.26.10.33.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:33:24 -0800 (PST)
Date: Tue, 26 Nov 2024 13:33:24 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust-1.75] Announcement
Message-ID: <c34d810d-d539-9613-074b-892d066340d0@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/843

I have just done the initial push of a kirkstone/rust-1.75 branch
to meta-lts-mixins.  The intent of this mixin is to track the ongoing
support for Rust 1.75 in the scarthgap LTS release, allowing a common
Rust toolchain for folks needing to target both kirkstone and scarthgap.

Note that the while the branch is derived from kirkstone/rust, their
common history differs a bit, as I discovered a few newer commits that
were out  of order with respect to oe-core history that needed to be
removed.  I have updated my backporting workflow to hopefully avoid that
from happening again in kirkstone/rust.

Please drop me a note if you use the mixin and hit an issue.

Scott


