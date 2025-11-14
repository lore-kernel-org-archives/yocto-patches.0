Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578BCDE014
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:49:17 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12444.1763102948141422399
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 22:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XT9hlbcY;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so11908795e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 22:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763102946; x=1763707746; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DrYk5GgcZ7n84/GVgA7IlX7XjegmQbaV+gq+lhG6fzE=;
        b=XT9hlbcYt15M2Oxo4TDrUeH9WohG0lDtojczoC+3OAprp3OkKS5007cKP/dV7hXFNW
         Po8GIjn0COF/TdtqMjVUJ7Pm5v83Y2W9t9tyAxEOKKPuAbjbu1DTpCBvXuZZxTUaoU2n
         JpaykXU+hLY8x+/WS3yYMD3CORInjrka9Ey+UQmh2vBzqdlItl3gizYVFfSkUUmi0wCa
         b2t3UDhgM57nt/4GLzu+5r46e8g4RYedQt+WfuEadLa/FuKAyKnENwuJqggMnthvkFNq
         MKg5aXFxbEUtnwcqg/OPzZEnegHGtKQQq2W8dYIfwZeWxfY/Qd6FX6D3OcfSvWxhDO3k
         Zq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763102946; x=1763707746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrYk5GgcZ7n84/GVgA7IlX7XjegmQbaV+gq+lhG6fzE=;
        b=wE7sUYPcxk+AXFQ9Q/507cRr9LqvVXJvkpf/Q0PZYf7vTrI2q7RoDnrj5GiTQ8kAte
         N51Dz+Sy8Yz52Aeh5U7Cvlp7KUjHi3JR9Vs/yU+uCaYMfZ2IGEg1cAmUo3MbNDDIAwxh
         rdbILS7DZzyckibpvXpLokaixEZ0lFItZqJXDI3bF8+iwm6reKFwdHBtojLYvOic5osM
         u5vKWFyn/ycRwPgOBd8/qGALXJJBZE5o/PaKtgRmIA7g4NpHxPN9v5dKWtWoMhkYgNS6
         VdSXpovmmX9JhDRQVMyz81eVdTjiiu4W21P58WJ3flC8EZz8LZ2rLspY7pjAjdMlis93
         Tedg==
X-Gm-Message-State: AOJu0YzyFKHb6re+ilD7nJJMRTDsdI+Djsd22yHszQobdMW1hfA163y6
	QcF4jk+nmsgBW4YpesCTbihAJkcYrgVJdpIg1sDDSIy9kdwYNgAQ+XP6sKhOWhuA
X-Gm-Gg: ASbGnct96+ciUXd8IdkToyQrktcCIbFJvuyPGi7LRHrhIDMF6lW/oomMOeIEWMyeec0
	wpfqv70oN3AK4nhoUNz/Nv3jQNBTPXvvi7U0L2PykxDkD38TxbRNK2iKpSKgIizEXJUu5RsXujP
	LdKqDgEtHk3UN1wE/enV8hH0WakfJoHPZ+zOALlrSINrV7iUPXg09QCSNJE58pIy/ck9OcpYM06
	xEn6LyCnlZkqgIIxeC5ZjZRgLTfHYejyPiHyHibfXnDgTofiBrYIsGIyRWf2XVnXYdovOLSb74x
	urpJ6flBmmgfyVV5Hr/rAQHVNCsXEV7C9y8U0BN/4ujdbOYlmq2QSnXWG4boEKN6MSi3HU2pvZI
	oA3Eer+uenXDgJl8OtW6rgGTL6VE77LsexUXeyRMbMbeT7hA70m5OCoILDaLHTY6+4jKUKDmVHd
	s46qFjgrTK/su2zQPdpns=
X-Google-Smtp-Source: AGHT+IFs7Ihjf02TU3f0jH4TYyp5ghO2YIIYS9qO/GD96BzzihEpKgVSdBIcuBn9OMoTFnGB0vRbfA==
X-Received: by 2002:a05:6000:2dc8:b0:42b:3cd2:e9bc with SMTP id ffacd0b85a97d-42b5936c65bmr1720936f8f.39.1763102946222;
        Thu, 13 Nov 2025 22:49:06 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f29c5fsm8030794f8f.46.2025.11.13.22.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 22:49:05 -0800 (PST)
Message-ID: <68b196e3-0657-420b-a493-800e548080fe@gmail.com>
Date: Fri, 14 Nov 2025 07:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] tensorflow-lite: package
 headers
To: yocto-patches@lists.yoctoproject.org,
 Martin Jansa <martin.jansa@gmail.com>
References: <20250913173840.3216545-1-skandigraun@gmail.com>
 <CA+chaQeaQqkjO1v+qoo308ZqH17Fk9VLiahPC3dBj_TknckhZQ@mail.gmail.com>
 <1877A5045FAF8D77.1051542@lists.yoctoproject.org>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <1877A5045FAF8D77.1051542@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 06:49:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2552

Apparently the latest version of libcamera for rpi (or at least its
dependency, libpisp) doesn't compile anymore with the master branch...
from my end please feel free to modify tf-lite as you wish. 

Thanks for noticing the issue.

On 11/13/25 19:40, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> On 11/13/25 18:18, Martin Jansa via lists.yoctoproject.org wrote:
>> Why should tensorflow-lite provide header files from flatbuffers,
>> cannot it use system headers from flatbuffers recipe? This breaks a
>> build for recipes which depend on both tensorflow-lite and flatbuffers
>> because of conflicts in RSS as in:
>> ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file
>> /usr/include/flatbuffers/array.h is installed by both tensorflow-lite
>> and flatbuffers, aborting
>>
>> I can send a patch to remove them (I have it locally).
> Hmmmm... that was a very long time ago, hard to remember the details... 
>
> If there is a flatbuffers recipe, I guess it would be usable, and most
> likely you are right, it would be more appropriate instead of this.
> I remember I added this for libamera-apps in meta-rpi - I can test it
> tomorrow and ping back, if that would be okay for you.
>
>> On Sat, Sep 13, 2025 at 7:38 PM Gyorgy Sarvari via
>> lists.yoctoproject.org <skandigraun=gmail.com@lists.yoctoproject.org>
>> wrote:
>>> The headers are not packages with tensorflow-lite, making it not easy to
>>> compile any applications using them.
>>>
>>> This patch copies the headers from the source and output folder to
>>> the includedir.
>>>
>>> The patch was derived from the content of a pre-compiled tflite package[1],
>>> and from compilation error messages that were returned by rpicam-apps
>>> recipe (which uses this recipe as an optional dependency)
>>>
>>> [1]: https://github.com/prepkg/tensorflow-lite-raspberrypi/releases/tag/2.20.0
>>>
>>> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
>>> ---
>>>  .../tensorflow/tensorflow-lite_2.19.0.bb      | 23 +++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>
>>> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
>>> index 14a538a..786507e 100644
>>> --- a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
>>> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
>>> @@ -114,6 +114,29 @@ do_install() {
>>>          ${D}${datadir}/label_image
>>>
>>>
>>> +    # install the headers also
>>> +    cd ${S}
>>> +    for header in `find ./tensorflow/lite -type f -name *.h`; do
>>> +        install -D -m 0644 $header ${D}${includedir}/$header
>>> +    done
>>> +
>>> +    for header in `find ./tensorflow/compiler/mlir -type f -name *.h`; do
>>> +        install -D -m 0644 $header ${D}${includedir}/$header
>>> +    done
>>> +
>>> +    for header in `find ./tensorflow/core/public -type f -name *.h`; do
>>> +        install -D -m 0644 $header ${D}${includedir}/$header
>>> +    done
>>> +    cd -
>>> +
>>> +    cd ${WORKDIR}/bazel/output_base/external/flatbuffers/include
>>> +    for header in `find ./flatbuffers -type f`; do
>>> +        install -D -m 0644 $header ${D}${includedir}/$header
>>> +    done
>>> +    cd -
>>> +
>>> +    # header installation done
>>> +
>>>      #echo "Installing pip package"
>>>      install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
>>>      ${STAGING_BINDIR_NATIVE}/pip3 install --disable-pip-version-check -v \
>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2543): https://lists.yoctoproject.org/g/yocto-patches/message/2543
> Mute This Topic: https://lists.yoctoproject.org/mt/115226423/6084445
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14038302/6084445/1344600526/xyzzy [skandigraun@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


