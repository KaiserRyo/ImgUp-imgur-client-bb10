// Default empty project template
import bb.cascades 1.0
import my.filepicker 1.0
import bb.data 1.0
import bb.system 1.0

// creates one page with a label

Page {
    property string imageSrc
    titleBar: TitleBar {
        title: "Upload history"
    }
    Container {
        ListView {
            id: uploadHistoryList
            dataModel: dataModel
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    ImageItem {
                        name: ListItemData.name
                        imageSource: "file://" + ListItemData.path
                        link: ListItemData.imgur_page
                        date: ListItemData.date
                    }
                },
                ListItemComponent {
                    type: "header"
                    Label {
                        visible: false
                    }
                }
            ]
            contextActions: [
                ActionSet {
                    title: qsTr("Link")
                    ActionItem {
                        title: qsTr("Copy imgur link")
                        onTriggered: {
                            _app.copyToClipboard(dataModel.data(uploadHistoryList.selected()).imgur_page);
                            console.log(dataModel.data(uploadHistoryList.selected()).imgur_page);
                            copyToast.show();
                        }
                        imageSource: "asset:///img/ic_copy_link.png"
                    }
                    ActionItem {
                        title: qsTr("Copy absolute link")
                        onTriggered: {
                            _app.copyToClipboard(dataModel.data(uploadHistoryList.selected()).original);
                            copyToast.show();
                        }
                        imageSource: "asset:///img/ic_copy_link_image.png"
                    }
                    //                    ActionItem {
                    //                        id: openInBrowser
                    //                        title: qsTr("Open in browser")
                    //                        onTriggered: {
                    //                            browserInvoke.query.uri = "http://wykop.pl";
                    //                            browserInvoke.query.updateQuery();
                    //                            browserInvoke.trigger("bb.action.OPEN");
                    //                        }
                    //                    }
                }
            ]
        }
    }
    actions: [
        ActionItem {
            id: uploadAction
            title: "Upload"
            imageSource: "asset:///img/ic_add.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                imgSelect.open();
            }
        }
    ]
    attachedObjects: [
        FilePicker {
            id: imgSelect
            type: FileType.Picture
            title: "Select Picture"
            onFileSelected: {
                uploadButton.visible = true;
                imagePreview.imageSource = selectedFiles[0];
                imageSrc = selectedFiles[0];
                uploadPage.open();
            }
        },
        Sheet {
            id: uploadPage
            content: Page {
                titleBar: TitleBar {
                    id: titleBar
                    title: "Upload"
                    dismissAction: ActionItem {
                        title: "Cancel"
                        onTriggered: {
                            uploadPage.close();
                        }
                    }
                }
                Container {
                    layout: DockLayout {
                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        ImageView {
                            id: imagePreview
                            objectName: "imagePreview"
                            preferredWidth: 400.0
                            scalingMethod: ScalingMethod.AspectFit
                        }
                        Container {
                            verticalAlignment: VerticalAlignment.Center
                            Button {
                                id: uploadButton
                                visible: false
                                text: "Upload"
                                verticalAlignment: VerticalAlignment.Center
                                onClicked: {
                                    visible = false;
                                    _uploader.uploadFile(imageSrc);
                                    sendingProgress.visible = true;
                                }
                            }
                            ProgressIndicator {
                                visible: false
                                id: sendingProgress
                            }
                        }
                    }
                }
            }
        },
        GroupDataModel {
            id: dataModel
        },
        DataSource {
            id: dataSource
            source: "db.db"
            query: "SELECT * FROM uploaded"
            onDataLoaded: {
                dataModel.clear();
                dataModel.insertList(data);
            }
        },
        SystemToast {
            id: uploadFinishedToast
            body: "Picture uploaded. Link copied to clipboard."
        },
        SystemToast {
            id: copyToast
            body: "Link copied to clipboard."
        },
        Invocation {
            id: browserInvoke
            query: InvokeQuery {
                invokeTargetId: "sys.browser"
                invokeActionId: "bb.action.OPEN"
                invokerIncluded: true
                uri: "http://imgur.com"
                onQueryChanged: browserInvoke.query.updateQuery()
            }
        }
    ]
    onCreationCompleted: {
        dataSource.load();
        _uploader.uploadDone.connect(function(result) {
                _cache.addSendImage(imageSrc, result);
                dataSource.load();
                sendingProgress.visible = false;
                sendingProgress.value = 0;
                uploadPage.close();
                _app.copyToClipboard(result["imgur_page"]);
                uploadFinishedToast.show();
            });
        _uploader.uploadError.connect(function() {
                uploadPage.close();
                sendingProgress.visible = false;
                sendingProgress.value = 0;
            });
        _uploader.uploadProgress.connect(function(send, to) {
                sendingProgress.toValue = to;
                sendingProgress.value = send;
            });
    }
}
