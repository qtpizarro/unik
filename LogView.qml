
import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:xTaLog
    width: app.width
    height: app.fs*4
    //clip: true
    color: app.c5
    border.width: 1
    border.color: app.c2
    property string bodyText: ''
    Flickable{
        id:fk
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: taLog.contentHeight
        //contentHeight: taLog.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true



        TextArea{
            id: taLog
            width: xTaLog.width-app.fs
            //height: xTaLog.height
            height: contentHeight
            anchors.centerIn: parent



            //settings.pluginsEnabled : true
            font.pixelSize: appSettingsUnik.lvfs
            //textFormat: Text.Normal
            textFormat: Text.RichText
            color: app.c2
            wrapMode: Text.WrapAnywhere

        }
    }

    Row{
        anchors.right: parent.right
        anchors.rightMargin: appSettingsUnik.lvfs*0.2
        anchors.bottom: xTaLog.top
        anchors.bottomMargin: appSettingsUnik.lvfs*0.2
        height: appSettingsUnik.lvfs*1.6

        spacing: appSettingsUnik.lvfs
        Boton{
            id:btnDownLVFS
            w:parent.height
            h: w
            t: ''
            d:''
            b:"#444444"
            c: app.c2
            onClicking: {
                if(appSettingsUnik.lvfs>12){
                    appSettingsUnik.lvfs--
                }
            }
            Text {
                text: '<b>A-</b>'
                font.pixelSize: parent.width*0.7
                anchors.centerIn: parent
                color: parent.c
            }
            Text {
                text: '<b>A</b>'
                font.pixelSize: parent.width*0.3
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 0-parent.width*0.3
                color: parent.c
            }
        }
        Boton{
            id:btnUpLVFS
            w:parent.height
            h: w
            t: ''
            b:"#444444"
            c: app.c2
            d:''
            onClicking: {
                if(appSettingsUnik.lvfs<24){
                    appSettingsUnik.lvfs++
                }
            }
            Text {
                text: '<b>A+</b>'
                font.pixelSize: parent.width*0.7
                anchors.centerIn: parent
                color: parent.c
            }
            Text {
                text: '<b>A</b>'
                font.pixelSize: parent.width*0.3
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 0-parent.width*0.3
                color: parent.c
            }
        }
        Boton{
            id:btnClear
            w:parent.height
            h: w
            t: '\uf12d'
            b:"#444444"
            c: app.c2
            d:''
            onClicking: {
                bodyText=''
                log('')
            }
        }

        Item{
            width: parent.height
            height: width
        }

        Boton{//a unik-tools
            w:parent.height
            h: w
            t: '\uf015'
            d:'unik-tools'
            b:"#444444"
            c: app.c1
            visible: !app.enUnikTools
            onClicking: {
                //unik.mainWindow(1).close();
                var main=appsDir+'/unik-tools/main.qml'
                unik.log('Loading Unik-Tools Home: '+main)
                engine.load(main)
            }
        }

        Boton{//Restart
            w:parent.height
            h: w
            t: '\uf021'
            d:'Reiniciar unik'
            b:"#444444"
            c: app.c1
            visible: !app.enUnikTools
            onClicking: {
                unik.restartApp()
            }
            Text {
                text: "\uf011"
                font.family: "FontAwesome"
                font.pixelSize: parent.height*0.3
                anchors.centerIn: parent
                color: app.c2
            }
        }
        Boton{//Quit
            w:parent.height
            h: w
            t: "\uf011"
            d:'Apagar unik'
            b:"#444444"
            c: app.c1
            visible: !app.enUnikTools
            onClicking: {
                Qt.quit()
            }
        }
    }
    function log(l){
        var d = new Date(Date.now())
        var t = '['+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()+'] '
        //taLog.text+=t+l+'\n'
        //taLog.text+=l+'<br />\n-------------------------------------AAAAAAAAAAAAAAAAAAAAA'
        if(l!==''){
            bodyText+=l+'<br>'
        }
        taLog.text='<html><body>'+bodyText+'</body></html>'
        if(taLog.height>xTaLog.height){
            fk.contentY = taLog.height-xTaLog.height
        }
    }
    Component.onCompleted: {
        //var stdinit='<b>Start Unik Init Message:</b>\u21b4<br>'+unik.initStdString.replace(/\n/g, '<br>')+'<br><b>End Unik Init Message.</b>'
        var s=(''+unik.initStdString).replace(/\n/g, '<br>')
        var stdinit='<b>Start Unik Init Message:</b>\u21b4<br>'+s+'<br><b>End Unik Init Message.</b><br>'
        var txt =''
        if(app.objectName==='unik-main-errors'){
            txt += "<b>OS: </b>"+Qt.platform.os
            txt += "<br><b>Errors: </b><br>"
            var s2=(''+unikError).replace(/\n/g, '<br>')
            txt+=s2
            txt += '<b>unik version: </b>'+version+'<br />\n'
            txt += '<b>AppName: </b>'+appName+'<br />\n'
            var e;
            if(unikError!==''){
                txt += '\n<b>Unik Errors:</b>\n'+unikError+'<br />\n'
            }else{
                txt += '\n<b>Unik Errors:</b>none<br />\n'
            }
            //txt += '\nErrors:\n'+unikError+'\n'
            txt += 'Doc location: '+appsDir+'/<br />\n'
            txt += 'host: '+host+'<br />\n'
            txt += 'user: '+ukuser+'<br />\n'
            if(ukuser==='unik-free'){
                txt += 'key: '+ukkey+'<br />\n'
            }else{
                txt += 'key: '
                var k= (''+ukkey).split('')
                for(var i=0;i<k.length;i++){
                    txt += '*'
                }
                txt += '<br />\n'
            }
            txt += 'sourcePath: '+sourcePath+'<br />\n'
            txt += '\n<b>config.json:</b>\n'+unik.getFile(appsDir+'/config.json')+'<br />\n'

            txt += '\nuserhost: ['+userhost+']<br />\n'
            bodyText+=txt+'<br>'+stdinit
        }else{
            bodyText+=stdinit
        }

        //console.log(stdinit)
        unik.setProperty("setInitString", true)
    }

}


