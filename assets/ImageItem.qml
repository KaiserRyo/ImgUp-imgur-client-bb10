import bb.cascades 1.0

Container {
    property alias imageSource: image.imageSource
    property alias name: nameLabel.text
    property alias link: linkLabel.text
    property alias date: dateLabel.text
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            preferredHeight: 200.0
            preferredWidth: 150.0
            minWidth: 150.0
            ImageView {
                id: image
                scalingMethod: ScalingMethod.AspectFit
                preferredHeight: 200.0
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                maxWidth: 120.0
            }
        }
        Container {
            layout: StackLayout {
            }
            Label {
                id: nameLabel
                text: "name"
            }
            Label {
                id: linkLabel
                text: "link"
                textStyle.fontStyle: FontStyle.Italic
                textStyle.fontSize: FontSize.Small
                textStyle.color: Color.LightGray
            }
            Label {
                id: dateLabel
                text: "date"
                textStyle.fontStyle: FontStyle.Default
                textStyle.fontSize: FontSize.XSmall
            }
        }
    }
    Divider {
    }
    bottomPadding: 10.0
    bottomMargin: 10.0
    topPadding: 10.0
    topMargin: 10.0
}
